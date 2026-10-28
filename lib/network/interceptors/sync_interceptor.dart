import 'package:http/http.dart' as http;

import '../core/network_interceptor.dart';
import '../core/network_request.dart';

/// Persistence boundary implemented by the app's offline queue/repository.
abstract interface class SyncQueue {
  /// Stores a request under a stable operation [key] for later replay.
  Future<void> enqueue(String key, NetworkRequest request);
}

/// On a transport failure, optionally stores safe-to-replay writes for later
/// application-controlled replay. Persistence/worker scheduling belongs to the
/// injected [SyncQueue] implementation.
class SyncInterceptor implements NetworkInterceptor {
  /// Uses [queue] to store eligible failed operations.
  const SyncInterceptor({required this.queue});

  final SyncQueue queue;

  @override
  /// Attempts the request. Only a failed, explicitly keyed, idempotent-safe
  /// request is enqueued; the original exception is rethrown to the caller.
  Future<http.StreamedResponse> intercept(
    NetworkRequest request,
    NetworkNext next,
  ) async {
    try {
      return await next(request);
    } catch (_) {
      final key = request.syncKey;
      if (key != null && key.isNotEmpty && request.canRetrySafely) {
        await queue.enqueue(key, request);
      }
      rethrow;
    }
  }
}
