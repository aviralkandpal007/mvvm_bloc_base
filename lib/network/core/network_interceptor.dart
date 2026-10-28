import 'package:http/http.dart' as http;

import 'network_request.dart';

typedef NetworkNext = Future<http.StreamedResponse> Function(
  NetworkRequest request,
);

/// Middleware contract for observing or changing one request/response exchange.
///
/// Interceptors execute in registration order on the way to the transport and
/// unwind in reverse order on the way back. Retry middleware can invoke [next]
/// more than once, so interceptors should avoid carrying stale per-attempt
/// state across calls.
abstract interface class NetworkInterceptor {
  /// Handles [request], optionally delegating to the next interceptor/transport
  /// through [next]. Catch errors here only when intentionally transforming or
  /// retrying them; otherwise rethrow to preserve useful failure details.
  Future<http.StreamedResponse> intercept(
    NetworkRequest request,
    NetworkNext next,
  );
}
