import '../../middleware/network_connector/network_connector.dart';
import '../../network/core/result.dart';
import '../../network/errors/network_exception.dart';
import 'demo_listing_item.dart';

/// Repository for demo listing data.
class DemoListingRepository {
  const DemoListingRepository(this._connector);

  final NetworkConnector _connector;

  /// Loads the demo listing through the connector API.
  Future<Result<List<DemoListingItem>, NetworkException>> fetchItems() =>
      _connector.fetchListing();
}
