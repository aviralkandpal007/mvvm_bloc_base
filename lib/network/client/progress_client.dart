import 'dart:async';

import '../core/cancel_token.dart';
import '../core/network_request.dart';
import '../core/network_progress.dart';
import '../errors/network_exception.dart';
import 'network_client.dart';

/// Streams downloads into caller-owned storage and reports byte-level progress.
///
/// No file-system API is used here, so the helper can work with platform files,
/// browser storage, in-memory sinks, or test sinks. The caller owns the sink's
/// lifecycle and should close/commit it when appropriate.
class ProgressClient {
  /// Uses [client] for URL resolution, transport, and middleware.
  const ProgressClient(this.client);

  final NetworkClient client;

  /// Downloads [path] to [sink] without building a complete in-memory file.
  ///
  /// [onProgress] receives a snapshot after each response chunk. If the server
  /// does not send a content length, [NetworkProgress.downloadFraction] is null.
  Future<void> download(
    String path,
    Sink<List<int>> sink, {
    Map<String, String>? headers,
    void Function(NetworkProgress progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    final response = await client.sendStreamed(
      NetworkRequest(
        method: 'GET',
        uri: client.resolve(path),
        headers: headers,
        progressCallback: onProgress,
        cancelToken: cancelToken,
      ),
    );
    // Drain an error body so it can be attached to the typed exception and the
    // transport can release the connection cleanly.
    if (response.statusCode < 200 || response.statusCode >= 400) {
      final bytes = await response.stream.toBytes();
      throw NetworkHttpException(
        statusCode: response.statusCode,
        message:
            'HTTP ${response.statusCode}${response.reasonPhrase == null ? '' : ': ${response.reasonPhrase}'}',
        uri: client.resolve(path),
        headers: response.headers,
        body: String.fromCharCodes(bytes),
      );
    }
    final total = response.contentLength;
    var received = 0;
    // Forward each chunk immediately. Memory use is bounded by a response
    // chunk, not by the full downloaded file size.
    await for (final chunk in response.stream) {
      sink.add(chunk);
      received += chunk.length;
      onProgress?.call(
        NetworkProgress(sent: 0, received: received, totalReceived: total),
      );
    }
  }

  /// Variant for asynchronous destinations whose writes return a `Future`.
  ///
  /// Awaiting each [writeChunk] applies backpressure: the next response chunk
  /// is not requested from the stream until the destination finishes writing.
  Future<void> downloadBytes(
    String path,
    Future<void> Function(List<int> chunk) writeChunk, {
    Map<String, String>? headers,
    void Function(NetworkProgress progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    final response = await client.sendStreamed(
      NetworkRequest(
        method: 'GET',
        uri: client.resolve(path),
        headers: headers,
        progressCallback: onProgress,
        cancelToken: cancelToken,
      ),
    );
    if (response.statusCode < 200 || response.statusCode >= 400) {
      final bytes = await response.stream.toBytes();
      throw NetworkHttpException(
        statusCode: response.statusCode,
        message:
            'HTTP ${response.statusCode}${response.reasonPhrase == null ? '' : ': ${response.reasonPhrase}'}',
        uri: client.resolve(path),
        headers: response.headers,
        body: String.fromCharCodes(bytes),
      );
    }
    final total = response.contentLength;
    var received = 0;
    // Await storage completion before advancing the response stream.
    await for (final chunk in response.stream) {
      await writeChunk(chunk);
      received += chunk.length;
      onProgress?.call(
        NetworkProgress(sent: 0, received: received, totalReceived: total),
      );
    }
  }
}
