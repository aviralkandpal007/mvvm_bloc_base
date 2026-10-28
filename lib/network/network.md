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
│   ├── network_request.dart
│   ├── network_response.dart
│   └── result.dart
├── errors/
│   └── network_exception.dart
├── interceptors/
│   ├── error_interceptor.dart
│   ├── logger_interceptor.dart
│   ├── retry_interceptor.dart
│   └── sync_interceptor.dart
├── network.dart
├── network_executor.dart
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
    LoggerInterceptor(),
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

### Application API connector

The abstract `NetworkConnector` in `lib/middleware/network_connector/`
declares app operations such as `fetchListing()`. Its singleton implementation
`NetworkWorker` owns the configured `NetworkClient`, base URL, headers, and
interceptors. Worker methods call the client's purpose-built `get`, `post`,
`put`, and `delete` methods through the small `NetworkExecutor` helper. The
executor centralizes JSON encoding and typed `Result<T, NetworkErrorType>` error
handling, so each worker API is a short method such as
`_executor.get('/posts', parse: DemoListingItem.parseList)`. Feature code
calls semantic operations like `fetchListing()`; it does not construct HTTP
requests or pass method strings.

`NetworkExecutor` runs the supplied top-level or static `parse` callback with
Flutter's `compute`, passing only the response body string and returning the
typed Dart value from the isolate. The demo passes the top-level
`demoListingItemsFromJson(String)` parser, matching the common generated-model
pattern of `<model>FromJson(String)` and `<model>ToJson(Model)` functions. This
also follows Flutter's documented `parsePhotos(String)` plus
`compute(parsePhotos, response.body)` pattern.

Register the singleton above `MaterialApp` so descendants can retrieve the
abstract API with `context.read<NetworkConnector>()`:

```dart
RepositoryProvider<NetworkConnector>.value(
  value: NetworkWorker.instance,
  child: MaterialApp(
    home: BlocProvider(
      create: (context) => DemoListingBloc(
        DemoListingRepository(context.read<NetworkConnector>()),
      )..add(const DemoListingLoadRequested()),
      child: const DemoListingScreen(),
    ),
  ),
)
```

The demo listing flow uses `NetworkConnector.fetchListing()`. Its repository
delegates to the connector, the Bloc translates load/refresh events into
loading, loaded, or failure states, and the screen only renders those states.
`NetworkWorker` is initialized once with `API_BASE_URL` (defaulting to the
JSONPlaceholder demo host) and reuses its client for every request.

`Result<T, E>` is the sealed utility pattern from Flutter's architecture docs;
it is not part of the Dart SDK. Network calls return `Ok<T, NetworkErrorType>`
or `Error<T, NetworkErrorType>`, so the app boundary exposes only a stable
error enum. Each enum value includes a localization key and English fallback;
UI code can use the key with its localization object from `BuildContext`, or
show the fallback message. Typed `NetworkException` subclasses remain inside
the networking implementation for transport mapping and diagnostic logging.
`NetworkWorker` lives for the app lifetime and reuses its client across calls.

## Interceptors and behavior

`LoggerInterceptor` logs request and response headers and bodies through the
app's shared `Logger` in `lib/utils/logger.dart`. It pretty-prints JSON,
redacts common credential fields, and truncates long payloads. It forwards
response chunks unchanged while collecting a copy for logging, so response
parsing continues normally. `NetworkExecutor` only handles typed parsing and
error conversion; it does not log payloads.

### Retry interceptor

`RetryInterceptor` applies exponential backoff and configurable retryable HTTP
statuses. It retries safe/idempotent methods by default (`GET`, `HEAD`,
`OPTIONS`, `PUT`, `DELETE`). `POST` is not retried unless a caller explicitly
sets `isIdempotent: true`, ideally only when the server supports idempotency
keys. Retry responses are drained so connections can be reused. Configure
attempts, backoff, and statuses through `RetryPolicy`.

### Logger interceptor

`LoggerInterceptor` writes method, URL, request and response bodies, status,
and duration using the app logger. It forwards response chunks unchanged and
caps the amount of response data retained for logging. It does not transform
or handle errors.

### Error interceptor and exception mapping

`ErrorInterceptor` converts non-success HTTP statuses into
`NetworkHttpException`, preserving status, URL, headers and text/JSON body when
available. Transport failures map to `NetworkUnreachableException` or
`NetworkConnectionException`, timeouts to `NetworkTimeoutException`,
cancellation to `NetworkCancelledException`, parsing failures to
`NetworkParseException`, and unknown failures to `NetworkUnknownException`.
Catch the `NetworkException` base type in data repositories, then branch on
`type` or inspect a subtype for details such as HTTP status.

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
- [Dart error handling](https://dart.dev/language/error-handling)
- [Dart class modifiers and sealed classes](https://dart.dev/language/class-modifiers)
- [Flutter Result pattern](https://docs.flutter.dev/app-architecture/design-patterns/result)
- [`http` package API](https://pub.dev/packages/http)
- [`http.Request`](https://pub.dev/documentation/http/latest/http/Request-class.html)
- [`http.Client`](https://pub.dev/documentation/http/latest/http/Client-class.html)
- [`http.BaseClient`](https://pub.dev/documentation/http/latest/http/BaseClient-class.html)

## Change log

- Moved the Flutter-documented sealed `Result<T>`, `Ok<T>`, and `Error<T>`
  types to `network/core/result.dart`.
- Added the abstract app API in
  `lib/middleware/network_connector/network_connector.dart` and its singleton
  implementation in `network_worker.dart`. Registered the abstraction above
  `MaterialApp` with `RepositoryProvider` for context-based access.
- Added a demo listing feature using `NetworkConnector` for a GET request and
  Bloc events/states for loading, success, failure, retry, and refresh.
- Added `NetworkExecutor` in `network/` to centralize typed GET/POST/PUT/
  DELETE calls, JSON conversion, and exception-to-`Result` mapping. The worker
  now delegates API methods to this helper without a separate request adapter.
- Updated `NetworkExecutor` to run a top-level/static response parser with
  `compute`, returning typed Dart models directly from the isolate instead of
  decoding generic JSON there and mapping models on the UI isolate.
- Exported `NetworkExecutor` and `Result<T>` from `network.dart`.
- Reduced buffered response copying in `NetworkClient.send` by accumulating
  streamed chunks in `BytesBuilder` instead of retaining a chunk list and then
  flattening it into a second list.
- Tightened `ErrorInterceptor` to treat only 2xx status codes as successful;
  redirects and other non-2xx statuses now map to `NetworkHttpException`.
- Added `NetworkErrorType` and a `type` getter to every `NetworkException`,
  plus `NetworkUnreachableException` for transport failures, so callers can
  handle offline, timeout, cancellation, HTTP, parse, and unknown cases without
  parsing message strings.
- Changed the network result error type to `NetworkErrorType`; enum values now
  carry localization keys and fallback messages, and the demo Bloc passes the
  enum through to the UI.
- Replaced `RequestLoggerInterceptor` with `LoggerInterceptor`; it logs request
  and response details through the app `Logger` while forwarding response
  streams intact. JSON is formatted, common credential fields are redacted,
  and large bodies are truncated.
