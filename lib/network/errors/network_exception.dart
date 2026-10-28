import 'package:http/http.dart' as http;

/// Stable categories for branching on network failures without parsing text.
enum NetworkErrorType {
  /// DNS, offline, refused, or otherwise unreachable transport.
  unreachable(
    'network.unreachable',
    'Can’t reach the server. Check your connection and try again.',
  ),

  /// Other transport-level failure.
  connection('network.connection', 'The connection failed. Please try again.'),

  /// Request exceeded its configured time budget.
  timeout('network.timeout', 'The request timed out. Please try again.'),

  /// Request was explicitly cancelled.
  cancelled('network.cancelled', 'The request was cancelled.'),

  /// Server returned a non-success HTTP status.
  http('network.http', 'The server request failed.'),

  /// Response JSON or decoded value was invalid.
  parse('network.parse', 'The server response could not be read.'),

  /// Failure did not match a known category.
  unknown('network.unknown', 'Something went wrong. Please try again.');

  const NetworkErrorType(this.localizationKey, this.message);

  /// Stable key for resolving a translated message from app localization.
  final String localizationKey;

  /// English fallback for apps that do not provide a localization lookup.
  final String message;
}

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

  /// Stable category suitable for exhaustive UI or repository handling.
  NetworkErrorType get type;

  @override
  String toString() => '$runtimeType: $message${uri == null ? '' : ' ($uri)'}';
}

class NetworkConnectionException extends NetworkException {
  /// The request could not reach or communicate with the server.
  const NetworkConnectionException(super.message, {super.uri, super.cause});

  @override
  NetworkErrorType get type => NetworkErrorType.connection;
}

/// The device cannot reach the host, commonly because it is offline or DNS
/// resolution failed. The underlying `package:http` client reports these as
/// [http.ClientException] on all supported platforms.
class NetworkUnreachableException extends NetworkConnectionException {
  /// Creates an unreachable-network failure.
  const NetworkUnreachableException(super.message, {super.uri, super.cause});

  @override
  NetworkErrorType get type => NetworkErrorType.unreachable;
}

class NetworkTimeoutException extends NetworkException {
  /// The configured time budget for the operation was exceeded.
  const NetworkTimeoutException(super.message, {super.uri, super.cause});

  @override
  NetworkErrorType get type => NetworkErrorType.timeout;
}

class NetworkCancelledException extends NetworkException {
  /// The caller or HTTP transport cancelled the operation.
  const NetworkCancelledException(super.message, {super.uri, super.cause});

  @override
  NetworkErrorType get type => NetworkErrorType.cancelled;
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

  @override
  NetworkErrorType get type => NetworkErrorType.http;
}

class NetworkParseException extends NetworkException {
  /// Response bytes could not be converted to the expected data representation.
  const NetworkParseException(super.message, {super.uri, super.cause});

  @override
  NetworkErrorType get type => NetworkErrorType.parse;
}

class NetworkUnknownException extends NetworkException {
  /// Fallback category for errors that do not match known network failures.
  const NetworkUnknownException(super.message, {super.uri, super.cause});

  @override
  NetworkErrorType get type => NetworkErrorType.unknown;
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
    return NetworkUnreachableException(
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
