import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TDropdownMenuTheme {
  TDropdownMenuTheme._();

  static DropdownMenuThemeData get lightDropdownMenuTheme =>
      DropdownMenuThemeData(
        textStyle: TextStyle(color: TAppColor.textPrimaryLight),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(TAppColor.surfaceLight),
        ),
      );
  static DropdownMenuThemeData get darkDropdownMenuTheme =>
      DropdownMenuThemeData(
        textStyle: TextStyle(color: TAppColor.textPrimaryDark),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(
            TAppColor.surfaceContainerDark,
          ),
        ),
      );
}
