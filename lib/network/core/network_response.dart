import 'dart:convert';

import 'package:http/http.dart' as http;

import 'network_request.dart';

/// Buffered HTTP response returned by `NetworkClient.send`.
///
/// This is convenient for JSON and small payloads. For large downloads, use
/// `NetworkClient.sendStreamed` and consume the stream incrementally instead.
class NetworkResponse {
  /// Creates a response wrapper with the originating request and fully read
  /// [bodyBytes].
  const NetworkResponse({
    required this.request,
    required this.response,
    required this.bodyBytes,
  });

  /// Request that generated this response.
  final NetworkRequest request;

  /// `package:http` response metadata (status, headers, and request details).
  final http.StreamedResponse response;

  /// Full response body as bytes. This is buffered in memory.
  final List<int> bodyBytes;

  /// HTTP status code.
  int get statusCode => response.statusCode;

  /// Response headers.
  Map<String, String> get headers => response.headers;

  /// URI requested by the application. It may differ from a redirected URL.
  Uri get requestUrl => request.uri;

  /// Decodes [bodyBytes] with [encoding] (UTF-8 by default).
  String bodyAsString([Encoding encoding = utf8]) => encoding.decode(bodyBytes);
}
