/// App-wide defaults shared by a [NetworkClient].
///
/// Keep environment-specific values here instead of scattering them across
/// repositories. Tests can inject a separate configuration and fake transport.
class NetworkConfig {
  /// Creates configuration for a client.
  const NetworkConfig({
    required this.baseUrl,
    this.defaultHeaders = const {'Accept': 'application/json'},
    this.connectTimeout = const Duration(seconds: 15),
    this.receiveTimeout = const Duration(seconds: 30),
  });

  /// Root URL used to resolve relative request paths.
  final String baseUrl;

  /// Headers attached to every request. Request-specific headers override them.
  final Map<String, String> defaultHeaders;

  /// Connection timeout hint for transports that can configure it separately.
  /// The default `package:http` client does not expose a separate connect
  /// timeout, so this field is available to custom transport implementations.
  final Duration connectTimeout;

  /// Maximum wait for the transport to return response headers/body stream.
  final Duration receiveTimeout;
}
