import 'demo_listing_item.dart';
import '../../network/errors/network_exception.dart';

/// States emitted while loading and displaying the demo listing.
sealed class DemoListingState {
  const DemoListingState();
}

/// No listing request has started.
final class DemoListingInitial extends DemoListingState {
  const DemoListingInitial();
}

/// The listing request is in progress.
final class DemoListingLoading extends DemoListingState {
  const DemoListingLoading();
}

/// The listing request completed successfully.
final class DemoListingLoaded extends DemoListingState {
  const DemoListingLoaded(this.items);

  final List<DemoListingItem> items;
}

/// The listing request failed with a category the UI can localize.
final class DemoListingFailure extends DemoListingState {
  const DemoListingFailure(this.error);

  final NetworkErrorType error;
}
