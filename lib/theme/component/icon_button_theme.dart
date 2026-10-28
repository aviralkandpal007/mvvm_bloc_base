import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TIconButtonTheme {
  TIconButtonTheme._();

  static IconButtonThemeData get lightIconButtonTheme => IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(TAppColor.outlineVariantDark),
    ),
  );
  static IconButtonThemeData get darkIconButtonTheme => IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(TAppColor.outlineLight),
    ),
  );
}
