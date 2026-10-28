import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TSwitchTheme {
  TSwitchTheme._();

  static SwitchThemeData get lightSwitchTheme => SwitchThemeData(
    thumbColor: WidgetStatePropertyAll(TAppColor.surfaceLight),
    trackColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? TAppColor.primary
          : TAppColor.outlineVariantLight,
    ),
    trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
  );
  static SwitchThemeData get darkSwitchTheme => SwitchThemeData(
    thumbColor: WidgetStatePropertyAll(TAppColor.textPrimaryLight),
    trackColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? TAppColor.primaryLight
          : TAppColor.outlineDark,
    ),
    trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
  );
}
