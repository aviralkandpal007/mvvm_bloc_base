import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TDatePickerTheme {
  TDatePickerTheme._();

  static DatePickerThemeData get lightDatePickerTheme => DatePickerThemeData(
    backgroundColor: TAppColor.surfaceLight,
    surfaceTintColor: Colors.transparent,
    headerBackgroundColor: TAppColor.primary,
    headerForegroundColor: TAppColor.onPrimaryLight,
    todayForegroundColor: WidgetStatePropertyAll(TAppColor.primaryDark),
    todayBackgroundColor: WidgetStatePropertyAll(
      TAppColor.primaryContainerLight,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
  static DatePickerThemeData get darkDatePickerTheme => DatePickerThemeData(
    backgroundColor: TAppColor.surfaceContainerDark,
    surfaceTintColor: Colors.transparent,
    headerBackgroundColor: TAppColor.primaryContainerDark,
    headerForegroundColor: TAppColor.textPrimaryDark,
    todayForegroundColor: WidgetStatePropertyAll(
      TAppColor.onPrimaryContainerDark,
    ),
    todayBackgroundColor: WidgetStatePropertyAll(
      TAppColor.primaryContainerDark,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
}
