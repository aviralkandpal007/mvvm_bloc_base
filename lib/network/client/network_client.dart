import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../core/network_config.dart';
import '../core/cancel_token.dart';
import '../core/network_interceptor.dart';
import '../core/network_progress.dart';
import '../core/network_request.dart';
import '../core/network_response.dart';
import '../errors/network_exception.dart';

/// Reusable HTTP client with request defaults and composable middleware.
///
/// The caller injects and owns the underlying `http.Client`. Close this wrapper
/// when its owning service is disposed. Tests should inject a mock client.
class NetworkClient {
  /// Creates a client with [config], the shared HTTP [client], and ordered
  /// [interceptors].
  NetworkClient({
    required this.config,
    required this._client,
    List<NetworkInterceptor> interceptors = const [],
  }) : _interceptors = List.unmodifiable(interceptors);

  /// Base URL, shared headers, and timeout defaults.
  final NetworkConfig config;
  final http.Client _client;
  final List<NetworkInterceptor> _interceptors;
  bool _closed = false;

  /// Resolves a relative [path] against [config.baseUrl] and merges query
  /// parameters with any already present on the resolved URI.
  Uri resolve(String path, [Map<String, String>? queryParameters]) {
    final base = Uri.parse(config.baseUrl);
    final resolved = base.resolve(path);
    if (queryParameters == null || queryParameters.isEmpty) return resolved;
    return resolved.replace(
      queryParameters: {...resolved.queryParameters, ...queryParameters},
    );
  }

  /// Executes [request], consumes its full response body, and returns buffered
  /// bytes. Use [sendStreamed] for large downloads to avoid buffering.
  Future<NetworkResponse> send(NetworkRequest request) async {
    if (_closed) throw StateError('NetworkClient is closed.');
    final merged = _prepareRequest(request);

    try {
      // First wait for the response stream. This timeout covers response
      // establishment; the body is consumed chunk-by-chunk just below.
      final streamed = await _execute(
        merged,
        0,
      ).timeout(merged.timeout ?? config.receiveTimeout);
      final total = streamed.contentLength;
      var received = 0;
      final bytes = BytesBuilder(copy: false);
      // Accumulate into one builder to avoid retaining both a chunk list and
      // a second flattened copy of the full response body.
      await for (final chunk in streamed.stream) {
        received += chunk.length;
        bytes.add(chunk);
        merged.progressCallback?.call(
          NetworkProgress(
            sent: 0,
            received: received,
            totalReceived: total,
            stage: NetworkProgressStage.response,
          ),
        );
      }
      return NetworkResponse(
        request: merged,
        response: streamed,
        bodyBytes: bytes.takeBytes(),
      );
    } on TimeoutException catch (error) {
      throw NetworkTimeoutException(
        message: 'Request timed out.',
        uri: merged.uri,
        cause: error,
      );
    } on NetworkException {
      rethrow;
    } catch (error) {
      throw mapNetworkException(error, merged.uri);
    }
  }

  /// Sends [request] and returns its unconsumed response stream.
  ///
  /// Use this for large files or incremental parsing/storage so the complete
  /// response does not need to reside in memory.
  Future<http.StreamedResponse> sendStreamed(NetworkRequest request) async {
    if (_closed) throw StateError('NetworkClient is closed.');
    final merged = _prepareRequest(request);
    try {
      return await _execute(
        merged,
        0,
      ).timeout(merged.timeout ?? config.receiveTimeout);
    } on TimeoutException catch (error) {
      throw NetworkTimeoutException(
        message: 'Request timed out.',
        uri: merged.uri,
        cause: error,
      );
    } on NetworkException {
      rethrow;
    } catch (error) {
      throw mapNetworkException(error, merged.uri);
    }
  }

  /// Applies defaults without mutating the caller's immutable request.
  NetworkRequest _prepareRequest(NetworkRequest request) => NetworkRequest(
    method: request.method,
    uri: request.uri,
    headers: {...config.defaultHeaders, ...request.headers},
    body: request.body,
    encoding: request.encoding,
    timeout: request.timeout ?? config.receiveTimeout,
    retryPolicy: request.retryPolicy,
    progressCallback: request.progressCallback,
    cancelToken: request.cancelToken,
    syncKey: request.syncKey,
    isIdempotent: request.isIdempotent,
  );

  /// Recursively builds the middleware chain. Once every interceptor has run,
  /// the final step sends the request through the injected transport.
  Future<http.StreamedResponse> _execute(NetworkRequest request, int index) {
    if (index >= _interceptors.length) return _sendTransport(request);
    return _interceptors[index].intercept(
      request,
      (nextRequest) => _execute(nextRequest, index + 1),
    );
  }

  /// Converts the portable request model into package:http's concrete request.
  Future<http.StreamedResponse> _sendTransport(NetworkRequest request) async {
    request.cancelToken?.throwIfCancelled();
    final outgoing = http.AbortableRequest(
      request.method.toUpperCase(),
      request.uri,
      abortTrigger: request.cancelToken?.whenCancelled,
    )..headers.addAll(request.headers);
    // Keep the accepted bodies explicit. A multipart or arbitrary stream body
    // needs a separate API so the module never silently buffers a large upload.
    if (request.body != null) {
      if (request.body is String) {
        outgoing.body = request.body as String;
        outgoing.encoding = request.encoding;
      } else if (request.body is List<int>) {
        outgoing.bodyBytes = request.body as List<int>;
      } else {
        throw ArgumentError.value(
          request.body,
          'body',
          'Use String or List<int> for request body.',
        );
      }
    }
    request.progressCallback?.call(
      NetworkProgress(
        sent: outgoing.contentLength,
        totalSent: outgoing.contentLength,
        received: 0,
        stage: NetworkProgressStage.request,
      ),
    );
    return _client.send(outgoing);
  }

  /// Sends a GET request. [onProgress] reports response bytes as they arrive.
  Future<NetworkResponse> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    void Function(NetworkProgress)? onProgress,
    CancelToken? cancelToken,
  }) => send(
    NetworkRequest(
      method: 'GET',
      uri: resolve(path, queryParameters),
      headers: headers,
      progressCallback: onProgress,
      cancelToken: cancelToken,
    ),
  );

  /// Sends a POST request. It is not retried unless [idempotent] is explicitly
  /// enabled by a caller whose server supports safe duplicate execution.
  Future<NetworkResponse> post(
    String path, {
    Object? body,
    Map<String, String>? headers,
    bool idempotent = false,
    String? syncKey,
    CancelToken? cancelToken,
  }) => send(
    NetworkRequest(
      method: 'POST',
      uri: resolve(path),
      body: body,
      headers: headers,
      isIdempotent: idempotent,
      syncKey: syncKey,
      cancelToken: cancelToken,
    ),
  );

  /// Sends an idempotent PUT request, eligible for configured retries.
  Future<NetworkResponse> put(
    String path, {
    Object? body,
    Map<String, String>? headers,
    String? syncKey,
    CancelToken? cancelToken,
  }) => send(
    NetworkRequest(
      method: 'PUT',
      uri: resolve(path),
      body: body,
      headers: headers,
      syncKey: syncKey,
      cancelToken: cancelToken,
    ),
  );

  /// Sends an idempotent DELETE request.
  Future<NetworkResponse> delete(
    String path, {
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) => send(
    NetworkRequest(
      method: 'DELETE',
      uri: resolve(path),
      headers: headers,
      cancelToken: cancelToken,
    ),
  );

  /// Closes the underlying injected client once.
  void close() {
    if (_closed) return;
    _closed = true;
    _client.close();
  }
}
