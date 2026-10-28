import 'dart:convert';

import 'cancel_token.dart';
import 'network_progress.dart';

/// Immutable description of one HTTP operation before it reaches transport.
///
/// The request carries HTTP details and cross-cutting metadata together so
/// interceptors can implement logging, retries, progress, or offline queueing
/// without depending on repository-specific models.
class NetworkRequest {
  /// Creates a request. Use `NetworkClient.resolve` to turn a relative path
  /// into the absolute [uri] expected by this object.
  NetworkRequest({
    required this.method,
    required this.uri,
    Map<String, String>? headers,
    this.body,
    this.encoding = utf8,
    this.timeout,
    this.retryPolicy,
    this.progressCallback,
    this.cancelToken,
    this.syncKey,
    this.isIdempotent,
  }) : headers = Map.unmodifiable(headers ?? const {});

  /// HTTP verb, such as `GET`, `POST`, `PUT`, or `DELETE`.
  final String method;

  /// Absolute destination URI.
  final Uri uri;

  /// Per-request headers, merged over [NetworkConfig.defaultHeaders].
  final Map<String, String> headers;

  /// Optional text or byte body. Current client convenience methods accept
  /// `String` and `List<int>`; multipart needs a separate streamed API.
  final Object? body;

  /// Encoding used when [body] is a string.
  final Encoding encoding;

  /// Timeout override for this one request.
  final Duration? timeout;

  /// Request-specific retry policy override.
  final RetryPolicy? retryPolicy;

  /// Reports request preparation and response-body progress to the caller.
  final void Function(NetworkProgress progress)? progressCallback;

  /// Optional cancellation signal for the in-flight operation.
  ///
  /// If omitted, the operation cannot be explicitly cancelled by its caller.
  final CancelToken? cancelToken;

  /// Optional durable queue key consumed by [SyncInterceptor].
  final String? syncKey;

  /// Explicitly overrides the default retry-safety check. Only set true when
  /// repeated server execution is safe (for example, with an idempotency key).
  final bool? isIdempotent;

  /// Whether retry middleware may safely repeat this request by default.
  ///
  /// Standard idempotent verbs are allowed. POST and custom verbs require an
  /// explicit [isIdempotent] opt-in.
  bool get canRetrySafely =>
      isIdempotent ??
      const {
        'GET',
        'HEAD',
        'OPTIONS',
        'PUT',
        'DELETE',
      }.contains(method.toUpperCase());
}

/// Attempt-count and backoff configuration for [RetryInterceptor].
class RetryPolicy {
  /// Creates a policy. [maxAttempts] includes the original request; `3` means
  /// one original call plus up to two retries.
  const RetryPolicy({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(milliseconds: 250),
    this.maxDelay = const Duration(seconds: 4),
    this.retryableStatusCodes = const {408, 425, 429, 500, 502, 503, 504},
  }) : assert(maxAttempts >= 1);

  /// Maximum total calls including the first attempt.
  final int maxAttempts;

  /// Delay before retry one; later delays double until [maxDelay].
  final Duration initialDelay;

  /// Maximum delay between any two attempts.
  final Duration maxDelay;

  /// HTTP response codes that may be retried for safe requests.
  final Set<int> retryableStatusCodes;

  /// Returns bounded exponential backoff for a 1-based retry number.
  Duration delayForRetry(int retryNumber) {
    final multiplier = 1 << (retryNumber - 1).clamp(0, 20);
    final milliseconds = initialDelay.inMilliseconds * multiplier;
    return Duration(
      milliseconds: milliseconds.clamp(0, maxDelay.inMilliseconds),
    );
  }
}
