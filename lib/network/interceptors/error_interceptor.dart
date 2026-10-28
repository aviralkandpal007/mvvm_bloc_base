import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/network_interceptor.dart';
import '../core/network_request.dart';
import '../errors/network_exception.dart';

/// Converts failed HTTP statuses into typed errors.
///
/// Error bodies are consumed to make them available on [NetworkHttpException].
/// Successful response streams are returned untouched for the caller to read.
class ErrorInterceptor implements NetworkInterceptor {
  /// Creates a stateless status-code mapper.
  const ErrorInterceptor();

  @override
  /// Delegates to the next layer and throws only for unsuccessful statuses.
  Future<http.StreamedResponse> intercept(
    NetworkRequest request,
    NetworkNext next,
  ) async {
    final response = await next(request);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }

    // Consume a failed response once so diagnostic text can be attached to the
    // exception and the underlying connection can be released.
    final bytes = await response.stream.toBytes();
    final contentType = response.headers['content-type']?.toLowerCase() ?? '';
    final body =
        contentType.isEmpty ||
            contentType.contains('text') ||
            contentType.contains('json')
        ? utf8.decode(bytes, allowMalformed: true)
        : null;
    throw NetworkHttpException(
      statusCode: response.statusCode,
      message:
          'HTTP ${response.statusCode}${response.reasonPhrase == null ? '' : ': ${response.reasonPhrase}'}',
      uri: request.uri,
      headers: response.headers,
      body: body,
    );
  }
}
