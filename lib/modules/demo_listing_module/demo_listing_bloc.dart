import 'package:bloc/bloc.dart';

import '../../network/core/result.dart';
import '../../network/errors/network_exception.dart';
import 'demo_listing_events.dart';
import 'demo_listing_item.dart';
import 'demo_listing_repository.dart';
import 'demo_listing_states.dart';

/// Coordinates listing events, repository requests, and UI states.
class DemoListingBloc extends Bloc<DemoListingEvent, DemoListingState> {
  DemoListingBloc(this._repository) : super(const DemoListingInitial()) {
    on<DemoListingLoadRequested>(_loadItems);
    on<DemoListingRefreshRequested>(_loadItems);
  }

  final DemoListingRepository _repository;

  Future<void> _loadItems(
    DemoListingEvent event,
    Emitter<DemoListingState> emit,
  ) async {
    emit(const DemoListingLoading());
    final result = await _repository.fetchItems();
    switch (result) {
      case Ok<List<DemoListingItem>, NetworkErrorType>(:final value):
        emit(DemoListingLoaded(value));
      case Error<List<DemoListingItem>, NetworkErrorType>(:final error):
        emit(DemoListingFailure(error));
    }
  }
}
