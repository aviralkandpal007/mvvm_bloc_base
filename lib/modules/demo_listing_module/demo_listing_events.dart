/// User actions handled by the demo listing feature.
sealed class DemoListingEvent {
  const DemoListingEvent();
}

/// Loads the listing when the screen first opens.
final class DemoListingLoadRequested extends DemoListingEvent {
  const DemoListingLoadRequested();
}

/// Loads the listing again after a user refresh or retry.
final class DemoListingRefreshRequested extends DemoListingEvent {
  const DemoListingRefreshRequested();
}
