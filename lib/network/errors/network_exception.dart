import 'package:http/http.dart' as http;

/// Base type for expected failures raised by the network module.
///
/// Repositories can catch this type once or inspect a subtype to handle an
/// HTTP status, transport failure, timeout, cancellation, or parse error.
sealed class NetworkException implements Exception {
  /// Creates an exception with a readable summary and optional request context.
  const NetworkException(this.message, {this.uri, this.cause});

  /// Human-readable summary. Localize or redact before showing to users.
  final String message;

  /// URI associated with the failed operation, when known.
  final Uri? uri;

  /// Original lower-level error for diagnostics and telemetry.
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message${uri == null ? '' : ' ($uri)'}';
}

class NetworkConnectionException extends NetworkException {
  /// The request could not reach or communicate with the server.
  const NetworkConnectionException(super.message, {super.uri, super.cause});
}

class NetworkTimeoutException extends NetworkException {
  /// The configured time budget for the operation was exceeded.
  const NetworkTimeoutException(super.message, {super.uri, super.cause});
}

class NetworkCancelledException extends NetworkException {
  /// The caller or HTTP transport cancelled the operation.
  const NetworkCancelledException(super.message, {super.uri, super.cause});
}

class NetworkHttpException extends NetworkException {
  /// The server returned an HTTP status outside the accepted success range.
  const NetworkHttpException({
    required this.statusCode,
    required String message,
    Uri? uri,
    Object? cause,
    this.headers = const {},
    this.body,
  }) : super(message, uri: uri, cause: cause);

  /// Server status code, such as 404 or 503.
  final int statusCode;

  /// Response headers, including optional retry hints.
  final Map<String, String> headers;

  /// Optional readable response body. Treat server-provided text as untrusted.
  final String? body;
}

class NetworkParseException extends NetworkException {
  /// Response bytes could not be converted to the expected data representation.
  const NetworkParseException(super.message, {super.uri, super.cause});
}

class NetworkUnknownException extends NetworkException {
  /// Fallback category for errors that do not match known network failures.
  const NetworkUnknownException(super.message, {super.uri, super.cause});
}

/// Maps common lower-level failures to the network module's typed errors.
/// Existing [NetworkException]s are kept intact to preserve their metadata.
NetworkException mapNetworkException(Object error, Uri uri) {
  if (error is NetworkException) return error;
  if (error is http.RequestAbortedException) {
    return NetworkCancelledException(
      'The request was cancelled.',
      uri: uri,
      cause: error,
    );
  }
  if (error is http.ClientException) {
    return NetworkConnectionException(
      error.message,
      uri: error.uri ?? uri,
      cause: error,
    );
  }
  if (error is FormatException || error is TypeError) {
    return NetworkParseException(
      'The server response could not be parsed.',
      uri: uri,
      cause: error,
    );
  }
  return NetworkUnknownException(
    'An unexpected network error occurred.',
    uri: uri,
    cause: error,
  );
}
