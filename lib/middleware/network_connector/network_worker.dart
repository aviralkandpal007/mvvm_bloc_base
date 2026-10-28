import 'package:http/http.dart' as http;

import '../../modules/demo_listing_module/demo_listing_item.dart';
import '../../network/client/network_client.dart';
import '../../network/core/network_config.dart';
import '../../network/network_executor.dart';
import '../../network/interceptors/error_interceptor.dart';
import '../../network/interceptors/logger_interceptor.dart';
import '../../network/interceptors/retry_interceptor.dart';
import '../../network/core/result.dart';
import '../../network/errors/network_exception.dart';
import 'network_connector.dart';

/// Singleton implementation that owns the configured HTTP client and API calls.
final class NetworkWorker implements NetworkConnector {
  /// The app-wide worker instance, initialized once and shared through DI.
  static final NetworkWorker instance = NetworkWorker._();

  factory NetworkWorker() => instance;

  NetworkWorker._()
    : _client = NetworkClient(
        config: const NetworkConfig(
          baseUrl: String.fromEnvironment(
            'API_BASE_URL',
            defaultValue: 'https://jsonplaceholder.typicode.com/',
          ),
          defaultHeaders: {'Accept': 'application/json'},
        ),
        client: http.Client(),
        interceptors: const [
          ErrorInterceptor(),
          RetryInterceptor(),
          LoggerInterceptor(),
        ],
      ) {
    _executor = NetworkExecutor(_client);
  }

  final NetworkClient _client;
  late final NetworkExecutor _executor;

  @override
  Future<Result<List<DemoListingItem>, NetworkException>> fetchListing() =>
      _executor.get('/posts', parse: demoListingItemsFromJson);
}
