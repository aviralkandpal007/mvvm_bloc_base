import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TToggleButtonsTheme {
  TToggleButtonsTheme._();

  static ToggleButtonsThemeData get lightToggleButtonsTheme =>
      ToggleButtonsThemeData(
        color: TAppColor.outlineDark,
        selectedColor: TAppColor.primaryDark,
        fillColor: TAppColor.primaryContainerLight,
        borderColor: TAppColor.outlineLight,
        selectedBorderColor: TAppColor.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      );
  static ToggleButtonsThemeData get darkToggleButtonsTheme =>
      ToggleButtonsThemeData(
        color: TAppColor.outlineLight,
        selectedColor: TAppColor.onPrimaryContainerDark,
        fillColor: TAppColor.primaryContainerDark,
        borderColor: TAppColor.outlineDark,
        selectedBorderColor: TAppColor.primaryLight,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      );
}
