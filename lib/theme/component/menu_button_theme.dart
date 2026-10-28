import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TMenuButtonTheme {
  TMenuButtonTheme._();

  static MenuButtonThemeData get lightMenuButtonTheme => MenuButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(TAppColor.outlineVariantDark),
    ),
  );
  static MenuButtonThemeData get darkMenuButtonTheme => MenuButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(TAppColor.outlineLight),
    ),
  );
}
