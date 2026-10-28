import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TTimePickerTheme {
  TTimePickerTheme._();

  static TimePickerThemeData get lightTimePickerTheme => TimePickerThemeData(
    backgroundColor: TAppColor.surfaceLight,
    dialBackgroundColor: TAppColor.surfaceContainerLight,
    dialHandColor: TAppColor.primary,
    dialTextColor: TAppColor.outlineVariantDark,
    hourMinuteColor: TAppColor.primaryContainerLight,
    hourMinuteTextColor: TAppColor.primaryDark,
    dayPeriodColor: TAppColor.surfaceAccentLight,
    dayPeriodTextColor: TAppColor.primaryDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
  static TimePickerThemeData get darkTimePickerTheme => TimePickerThemeData(
    backgroundColor: TAppColor.surfaceContainerDark,
    dialBackgroundColor: TAppColor.surfaceContainerHighDark,
    dialHandColor: TAppColor.primaryLight,
    dialTextColor: TAppColor.outlineLight,
    hourMinuteColor: TAppColor.primaryContainerDark,
    hourMinuteTextColor: TAppColor.onPrimaryContainerDark,
    dayPeriodColor: TAppColor.surfaceContainerHighDark,
    dayPeriodTextColor: TAppColor.onPrimaryContainerDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
}
