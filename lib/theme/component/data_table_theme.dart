import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TDataTableTheme {
  TDataTableTheme._();

  static DataTableThemeData get lightDataTableTheme => DataTableThemeData(
    headingRowColor: WidgetStatePropertyAll(TAppColor.surfaceContainerLight),
    headingTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: TAppColor.textPrimaryLight,
    ),
    dataTextStyle: TextStyle(color: TAppColor.outlineVariantDark),
    dividerThickness: 1,
    horizontalMargin: 16,
    columnSpacing: 24,
  );
  static DataTableThemeData get darkDataTableTheme => DataTableThemeData(
    headingRowColor: WidgetStatePropertyAll(TAppColor.surfaceContainerHighDark),
    headingTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: TAppColor.textPrimaryDark,
    ),
    dataTextStyle: TextStyle(color: TAppColor.outlineLight),
    dividerThickness: 1,
    horizontalMargin: 16,
    columnSpacing: 24,
  );
}
