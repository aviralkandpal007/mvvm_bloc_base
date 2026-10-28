import 'dart:async';

import '../errors/network_exception.dart';

/// Cancellation signal that can be attached to an outgoing [NetworkRequest].
///
/// Call [cancel] to abort the request and, where the HTTP transport supports
/// abortable requests, stop its in-flight network operation or response stream.
/// Reuse one token per operation; cancellation is one-way.
class CancelToken {
  final Completer<void> _completer = Completer<void>();
  Object? _reason;

  /// Whether [cancel] has already been called.
  bool get isCancelled => _completer.isCompleted;

  /// Optional reason provided to [cancel].
  Object? get reason => _reason;

  /// Future consumed by `package:http`'s `AbortableRequest`.
  ///
  /// It completes normally (never with an error), as required by the HTTP
  /// package. Avoid completing this future directly; call [cancel] instead.
  Future<void> get whenCancelled => _completer.future;

  /// Cancels the associated request. Subsequent calls have no effect.
  void cancel([Object? reason]) {
    if (isCancelled) return;
    _reason = reason;
    _completer.complete();
  }

  /// Throws a [NetworkCancelledException] if this token has been cancelled.
  void throwIfCancelled() {
    if (!isCancelled) return;
    throw NetworkCancelledException(
      message: reason?.toString() ?? 'The request was cancelled.',
      cause: reason,
    );
  }
}
