import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TMenuTheme {
  TMenuTheme._();

  static MenuThemeData get lightMenuTheme => MenuThemeData(
    style: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(TAppColor.surfaceLight),
    ),
  );
  static MenuThemeData get darkMenuTheme => MenuThemeData(
    style: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(TAppColor.surfaceContainerDark),
    ),
  );
}
