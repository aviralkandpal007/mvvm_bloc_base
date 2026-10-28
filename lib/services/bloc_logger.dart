import 'package:bloc/bloc.dart';

import '../utils/logger.dart';

/// This class will work as a logger for the bloc state management, it will
/// register all the changes that any bloc class will go through. Usually when
/// any bloc will initialize, dispose, emit state or register any event this
/// will get triggered
class BlocLogger extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    Logger.info("onCreated -- ${bloc.runtimeType}");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Logger.info("onChange -- ${bloc.runtimeType}, $change");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger.error(
      "onError -- ${bloc.runtimeType}",
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    Logger.info("onClose -- ${bloc.runtimeType}");
    super.onClose(bloc);
  }
}
