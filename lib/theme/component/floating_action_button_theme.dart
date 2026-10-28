import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TFloatingActionButtonTheme {
  TFloatingActionButtonTheme._();

  static FloatingActionButtonThemeData get lightFloatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: TAppColor.primary,
        foregroundColor: TAppColor.onPrimaryLight,
        elevation: 3,
        focusElevation: 4,
        hoverElevation: 4,
        highlightElevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      );
  static FloatingActionButtonThemeData get darkFloatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: TAppColor.primaryLight,
        foregroundColor: TAppColor.textPrimaryLight,
        elevation: 3,
        focusElevation: 4,
        hoverElevation: 4,
        highlightElevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      );
}
