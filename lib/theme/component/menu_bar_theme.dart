import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TMenuBarTheme {
  TMenuBarTheme._();

  static MenuBarThemeData get lightMenuBarTheme => MenuBarThemeData(
    style: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(TAppColor.surfaceContainerLight),
    ),
  );
  static MenuBarThemeData get darkMenuBarTheme => MenuBarThemeData(
    style: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(
        TAppColor.surfaceContainerHighDark,
      ),
    ),
  );
}
