import 'dart:async';

import 'package:http/http.dart' as http;

import '../core/network_interceptor.dart';
import '../core/network_request.dart';
import '../errors/network_exception.dart';

/// Repeats eligible requests after temporary transport or server failures.
///
/// Place `ErrorInterceptor` before this interceptor in registration order so
/// retry can inspect typed HTTP exceptions produced by the downstream layer.
class RetryInterceptor implements NetworkInterceptor {
  /// Uses [defaultPolicy] unless a request provides its own retry policy.
  const RetryInterceptor({this.defaultPolicy = const RetryPolicy()});

  final RetryPolicy defaultPolicy;

  @override
  /// Runs one or more attempts, draining retryable responses before waiting so
  /// their connection resources are released.
  Future<http.StreamedResponse> intercept(
    NetworkRequest request,
    NetworkNext next,
  ) async {
    final policy = request.retryPolicy ?? defaultPolicy;
    var attempt = 0;
    while (true) {
      attempt++;
      var retryFromResponse = false;
      try {
        final response = await next(request);
        // ErrorInterceptor is downstream and normally turns error statuses into
        // typed errors. This also handles custom pipeline orderings.
        final statusCanRetry = policy.retryableStatusCodes.contains(
          response.statusCode,
        );
        if (!request.canRetrySafely ||
            !statusCanRetry ||
            attempt >= policy.maxAttempts) {
          return response;
        }
        // A response body cannot be reused for the next attempt. Consume it
        // before retrying to allow the underlying client to reuse connections.
        await response.stream.drain<void>();
        retryFromResponse = true;
      } catch (error) {
        if (error is NetworkHttpException) {
          if (!request.canRetrySafely ||
              !policy.retryableStatusCodes.contains(error.statusCode) ||
              attempt >= policy.maxAttempts) {
            rethrow;
          }
          retryFromResponse = true;
        } else if (!request.canRetrySafely ||
            attempt >= policy.maxAttempts ||
            !_isRetryableTransportError(error)) {
          rethrow;
        }
      }
      if (retryFromResponse || attempt < policy.maxAttempts) {
        // Exponential backoff reduces pressure on a temporarily unhealthy server.
        await Future<void>.delayed(policy.delayForRetry(attempt));
      }
    }
  }

  bool _isRetryableTransportError(Object error) =>
      error is http.ClientException || error is TimeoutException;
}
