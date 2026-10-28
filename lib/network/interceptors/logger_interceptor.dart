import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../../utils/logger.dart';
import '../core/network_interceptor.dart';
import '../core/network_request.dart';

/// Logs request and response details through the app's shared logger.
class LoggerInterceptor implements NetworkInterceptor {
  const LoggerInterceptor();

  @override
  Future<http.StreamedResponse> intercept(
    NetworkRequest request,
    NetworkNext next,
  ) async {
    final startedAt = DateTime.now();
    Logger.debug(
      '--> ${request.method.toUpperCase()} ${request.uri}\n'
      'Request body:\n${_formatBody(request.body)}',
      tag: 'LoggerInterceptor',
    );

    final response = await next(request);
    return http.StreamedResponse(
      _logResponseBody(response.stream, request, response, startedAt),
      response.statusCode,
      contentLength: response.contentLength,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      reasonPhrase: response.reasonPhrase,
    );
  }

  Stream<List<int>> _logResponseBody(
    Stream<List<int>> stream,
    NetworkRequest request,
    http.StreamedResponse response,
    DateTime startedAt,
  ) async* {
    final bodyBytes = BytesBuilder(copy: false);
    var receivedBytes = 0;
    await for (final chunk in stream) {
      receivedBytes += chunk.length;
      if (bodyBytes.length < _maxLoggedBytes) {
        final remaining = _maxLoggedBytes - bodyBytes.length;
        bodyBytes.add(
          remaining < chunk.length ? chunk.sublist(0, remaining) : chunk,
        );
      }
      yield chunk;
    }

    final elapsed = DateTime.now().difference(startedAt).inMilliseconds;
    final body = utf8.decode(bodyBytes.takeBytes(), allowMalformed: true);
    final truncated = receivedBytes > _maxLoggedBytes;
    Logger.debug(
      '<-- ${response.statusCode} ${request.uri} (${elapsed}ms)\n'
      'Response body:\n${_formatBody(body)}${truncated ? '\n… <truncated>' : ''}',
      tag: 'LoggerInterceptor',
    );
  }

  String _formatBody(Object? body) {
    if (body == null) return '<empty>';
    final text = body is List<int>
        ? utf8.decode(body, allowMalformed: true)
        : body.toString();
    return text.length <= _maxLoggedChars
        ? text
        : '${text.substring(0, _maxLoggedChars)}… <truncated>';
  }

  static const _maxLoggedBytes = 32 * 1024;
  static const _maxLoggedChars = 6000;
}
