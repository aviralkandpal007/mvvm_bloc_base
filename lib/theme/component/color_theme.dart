import 'package:flutter/material.dart';

import '../app_color.dart';

/// Application color schemes and scaffold/surface colors.
class TColorTheme {
  TColorTheme._();

  static Color get _seedColor => TAppColor.primary;
  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.light,
    surface: TAppColor.backgroundLight,
  );
  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
    seedColor: TAppColor.primaryLight,
    brightness: Brightness.dark,
    surface: TAppColor.surfaceDark,
  );

  static Color get lightScaffoldBackground => TAppColor.backgroundLight;
  static Color get darkScaffoldBackground => TAppColor.backgroundDark;
}
