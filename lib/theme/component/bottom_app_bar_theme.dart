import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TBottomAppBarTheme {
  TBottomAppBarTheme._();

  static BottomAppBarThemeData get lightBottomAppBarTheme =>
      BottomAppBarThemeData(
        color: TAppColor.surfaceLight,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
      );
  static BottomAppBarThemeData get darkBottomAppBarTheme =>
      BottomAppBarThemeData(
        color: TAppColor.surfaceDark,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
      );
}
