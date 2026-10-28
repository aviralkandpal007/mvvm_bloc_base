import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TDividerTheme {
  TDividerTheme._();

  static DividerThemeData get lightDividerTheme => DividerThemeData(
    color: TAppColor.outlineVariantLight,
    thickness: 1,
    space: 1,
  );
  static DividerThemeData get darkDividerTheme => DividerThemeData(
    color: TAppColor.outlineVariantDark,
    thickness: 1,
    space: 1,
  );
}
