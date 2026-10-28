import 'package:flutter/foundation.dart';

/// This logger is used for logging in the class that will help us to see
/// data on the console with the help of which we will be able to track errors
/// and warnings in the application lifecycle
class Logger {
  static const int _wrapWidth = 90;

  static void info(String message, {String? tag}) {
    _printLog('INFO', message, tag: tag);
  }

  static void debug(String message, {String? tag}) {
    _printLog('DEBUG', message, tag: tag);
  }

  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _printLog('ERROR', message, tag: tag, error: error, stackTrace: stackTrace);
  }

  static void _printLog(
    String level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;

    final timestamp = DateTime.now().toIso8601String();
    const border =
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━';

    debugPrint('');
    debugPrint(border, wrapWidth: _wrapWidth);
    debugPrint('[$tag][$level] $timestamp', wrapWidth: _wrapWidth);
    debugPrint('MESSAGE: $message', wrapWidth: _wrapWidth);

    if (error != null) {
      debugPrint('ERROR: $error', wrapWidth: _wrapWidth);
    }

    if (stackTrace != null) {
      debugPrint('STACK TRACE:\n$stackTrace', wrapWidth: _wrapWidth);
    }

    debugPrint(border, wrapWidth: _wrapWidth);
  }
}
