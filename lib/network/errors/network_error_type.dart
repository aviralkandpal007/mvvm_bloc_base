part of 'network_exception.dart';

/// Error categories returned by the network layer and thrown by its client.
///
/// The localization key lets UI code resolve a translated message from its
/// `BuildContext`; [message] is the fallback for apps without localization.
enum NetworkErrorType implements Exception {
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

/// Converts lower-level HTTP and Dart failures to the network error enum.
NetworkErrorType mapNetworkError(Object error) {
  if (error is NetworkErrorType) return error;
  if (error is http.RequestAbortedException) return NetworkErrorType.cancelled;
  if (error is http.ClientException) return NetworkErrorType.unreachable;
  if (error is FormatException || error is TypeError) {
    return NetworkErrorType.parse;
  }
  return NetworkErrorType.unknown;
}
