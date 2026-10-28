import '../../modules/demo_listing_module/demo_listing_item.dart';
import '../../network/core/result.dart';
import '../../network/errors/network_exception.dart';

/// App API contract available to repositories through dependency injection.
abstract interface class NetworkConnector {
  /// Loads the demo listing.
  Future<Result<List<DemoListingItem>, NetworkException>> fetchListing();
}
