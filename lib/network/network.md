# Network Module Guide

This module provides a cross-platform HTTP client foundation using Flutter's
recommended `package:http` transport. It includes typed errors, composable
interceptors, retry policy, request logging, sync-queue integration, and
streaming download progress.

The Dart implementation includes explanatory doc comments on public classes,
fields, and functions. This guide explains how the pieces fit together; read
comments in each file for line-by-line context while editing the code.

## Flutter networking guidance

The design follows the Flutter networking cookbook and API guidance:

- Use `package:http` for portable HTTP instead of `dart:io` or `dart:html`.
- Inject and reuse an `http.Client`. This supports connection reuse and makes
  client-level code easy to fake in tests.
- Check HTTP status and throw meaningful errors; do not treat a failed response
  as successful or return null for a failed request.
- Parse large JSON payloads away from the UI isolate using Flutter's `compute`
  when parsing work is expensive. Pass simple data across isolate boundaries.
- Stream large downloads rather than buffering their entire body in memory.
- Grant platform network permission where required (Android `INTERNET`; macOS
  network-client entitlement). Flutter networking documentation is linked below.

## Layout

```text
lib/network/
├── client/
│   ├── network_client.dart
│   └── progress_client.dart
├── core/
│   ├── network_config.dart
│   ├── network_interceptor.dart
│   └── network_request.dart
├── errors/
│   └── network_exception.dart
├── interceptors/
│   ├── error_interceptor.dart
│   ├── request_logger_interceptor.dart
│   ├── retry_interceptor.dart
│   └── sync_interceptor.dart
├── network.dart
└── network.md
```

`package:http` does not expose Dio-style interceptors itself. This module
defines `NetworkInterceptor` middleware around its `Client.send` transport.
Each interceptor receives a request and a `next` callback; requests flow
through interceptors in registration order, then to the injected HTTP client.
Responses and errors unwind back through that stack in reverse order.

## Build a client

```dart
import 'package:http/http.dart' as http;
import 'package:mvvm_bloc_base/network/network.dart';

final client = NetworkClient(
  config: const NetworkConfig(
    baseUrl: 'https://api.example.com/v1/',
    defaultHeaders: {'Accept': 'application/json'},
  ),
  client: http.Client(),
  interceptors: const [
    RequestLoggerInterceptor(),
    RetryInterceptor(),
    ErrorInterceptor(),
  ],
);
```

The package import above assumes this repository's package name. If the package
is renamed, update the import to match `pubspec.yaml`. Inject a fake or mock
`http.Client` in unit tests. The caller owns and must close the client (or use
dependency injection to manage its lifetime).

### Request methods

```dart
final response = await client.get(
  '/users',
  queryParameters: {'page': '1'},
);

final created = await client.post(
  '/users',
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'name': 'Ada'}),
);
```

`NetworkClient` merges configured and request headers, resolves relative paths
against the base URL, applies the timeout, executes interceptors, buffers a
normal response and returns `NetworkResponse`. Request bodies currently accept
`String` or `List<int>`; multipart uploads should be implemented as a separate
streamed upload API before using `http.MultipartRequest`.

## Interceptors and behavior

### Retry interceptor

`RetryInterceptor` applies exponential backoff and configurable retryable HTTP
statuses. It retries safe/idempotent methods by default (`GET`, `HEAD`,
`OPTIONS`, `PUT`, `DELETE`). `POST` is not retried unless a caller explicitly
sets `isIdempotent: true`, ideally only when the server supports idempotency
keys. Retry responses are drained so connections can be reused. Configure
attempts, backoff, and statuses through `RetryPolicy`.

### Request logger

`RequestLoggerInterceptor` writes method, URL, status, duration and error
messages in debug mode. It intentionally does not log headers or bodies, which
might contain credentials, personal data or large payloads. A custom sink can
be supplied for tests or a redacted logging service.

### Error interceptor and exception mapping

`ErrorInterceptor` converts non-success HTTP statuses into
`NetworkHttpException`, preserving status, URL, headers and text/JSON body when
available. Transport failures map to `NetworkConnectionException`, timeouts to
`NetworkTimeoutException`, cancellation to `NetworkCancelledException`, parsing
failures to `NetworkParseException`, and unknown failures to
`NetworkUnknownException`. Catch the `NetworkException` base type in data
repositories, then selectively handle subclasses.

Install `ErrorInterceptor` before `RetryInterceptor` in the list. Because the
middleware executes downstream in registration order, the request passes from
the first interceptor to the last and then the transport; response handling
unwinds in reverse order. The retry interceptor can then catch typed
`NetworkHttpException`s generated by the downstream error interceptor and
retry only configured statuses.

### Sync interceptor

`SyncInterceptor` delegates failed safe-to-replay work to an injected `SyncQueue`
using `syncKey`. This module defines the contract only; durable queue storage,
authentication refresh, background scheduling, conflict resolution, and
replay policy are application-specific and should be implemented by the app.
Do not persist credentials in queued requests. Queue only operations that are
idempotent or protected by a server-supported idempotency key.

## Progress and downloads

`NetworkProgress` carries sent/received byte counts, optional content lengths,
fractions when lengths are known, and the request/response stage. Supply an
`onProgress` callback to `get` for response-body progress. Upload byte progress
is not implemented for the buffered `String`/`List<int>` API; request progress
currently indicates that the request bytes are ready to send, not confirmed
server receipt.

For large downloads use `ProgressClient` and a caller-owned `Sink<List<int>>`
or asynchronous `writeChunk` callback:

```dart
final progressClient = ProgressClient(client);
await progressClient.download(
  '/files/archive.zip',
  outputSink,
  onProgress: (progress) {
    print(progress.downloadFraction);
  },
);

// Or await storage writes one chunk at a time:
await progressClient.downloadBytes(
  '/files/archive.zip',
  (chunk) => storage.write(chunk),
);
```

The sink lets the application stream bytes directly to its storage layer. The
network module deliberately does not use `dart:io File`, so it remains
cross-platform. The caller should close the sink according to its storage API.
Unknown response lengths produce `downloadFraction == null`.

## Sync and offline operation

Provide a durable `SyncQueue` implementation (for example backed by the
repository's database) and add `SyncInterceptor(queue: queue)` to the pipeline.
Queue entries should include an operation key, safe request data, creation
time, retry count, and idempotency metadata. Replays should be bounded, ordered
as needed by the domain, and observable by application state. Avoid claiming a
request has synced until the server confirms it. Background execution requires
a platform/background-work solution and is not started by this module itself.

## Important limitations / extension points

- The HTTP package's plain `Client` supports request/response streams; the
  high-level API buffers ordinary responses. Large file retrieval should use
  `ProgressClient`.
- Timeout currently covers waiting for the streamed response headers. Add a
  stream-level timeout/cancellation policy when stricter body deadlines are
  needed.
- Upload progress and multipart uploads need a dedicated streamed request
  implementation; do not report body bytes as uploaded merely because they
  were queued.
- Cancellation can be implemented with `package:http`'s abortable request
  support, but a public cancellation token is not included yet.
- Keep authorization token acquisition outside logs; add a dedicated auth
  interceptor only when token refresh rules and concurrency behavior are
  defined for this application.

## Flutter documentation references

- [Networking overview](https://docs.flutter.dev/data-and-backend/networking)
- [Fetch data from the internet](https://docs.flutter.dev/cookbook/networking/fetch-data)
- [Parse JSON in the background](https://docs.flutter.dev/cookbook/networking/background-parsing)
- [`http` package API](https://pub.dev/packages/http)
- [`http.Client`](https://pub.dev/documentation/http/latest/http/Client-class.html)
- [`http.BaseClient`](https://pub.dev/documentation/http/latest/http/BaseClient-class.html)
