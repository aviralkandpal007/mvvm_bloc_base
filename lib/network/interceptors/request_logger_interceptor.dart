import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core/network_interceptor.dart';
import '../core/network_request.dart';

typedef NetworkLogSink = void Function(String message);

/// Logs basic request lifecycle information in debug builds.
///
/// Headers and bodies are deliberately omitted because they may contain
/// credentials, personal data, or large payloads.
class RequestLoggerInterceptor implements NetworkInterceptor {
  /// Optionally writes redacted log lines to [sink]. Defaults to `debugPrint`.
  const RequestLoggerInterceptor({this._sink});

  final NetworkLogSink? _sink;

  @override
  /// Logs method/URL, duration/status, then returns the untouched response.
  Future<http.StreamedResponse> intercept(
    NetworkRequest request,
    NetworkNext next,
  ) async {
    // Track duration without reading or consuming the response stream.
    final startedAt = DateTime.now();
    _log('--> ${request.method.toUpperCase()} ${request.uri}');
    try {
      final response = await next(request);
      _log(
        '<-- ${response.statusCode} ${request.uri} (${DateTime.now().difference(startedAt).inMilliseconds}ms)',
      );
      return response;
    } catch (error) {
      _log('<-- ERROR ${request.uri}: $error');
      rethrow;
    }
  }

  /// Keeps production builds quiet unless debug logging is intentionally added.
  void _log(String message) {
    if (kDebugMode) (_sink ?? debugPrint)(message);
  }
}
