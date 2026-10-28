import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TTooltipTheme {
  TTooltipTheme._();

  static TooltipThemeData get lightTooltipTheme => TooltipThemeData(
    decoration: BoxDecoration(
      color: TAppColor.surfaceContainerHighDark,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    textStyle: TextStyle(color: TAppColor.textPrimaryDark),
    waitDuration: Duration(milliseconds: 500),
  );
  static TooltipThemeData get darkTooltipTheme => TooltipThemeData(
    decoration: BoxDecoration(
      color: TAppColor.outlineVariantLight,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    textStyle: TextStyle(color: TAppColor.textPrimaryLight),
    waitDuration: Duration(milliseconds: 500),
  );
}
