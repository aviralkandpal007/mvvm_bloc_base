import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TProgressIndicatorTheme {
  TProgressIndicatorTheme._();

  static ProgressIndicatorThemeData get lightProgressIndicatorTheme =>
      ProgressIndicatorThemeData(
        color: TAppColor.primary,
        linearTrackColor: TAppColor.primaryContainerLight,
        circularTrackColor: TAppColor.primaryContainerLight,
        refreshBackgroundColor: TAppColor.surfaceLight,
      );
  static ProgressIndicatorThemeData get darkProgressIndicatorTheme =>
      ProgressIndicatorThemeData(
        color: TAppColor.primaryLight,
        linearTrackColor: TAppColor.outlineVariantDark,
        circularTrackColor: TAppColor.outlineVariantDark,
        refreshBackgroundColor: TAppColor.surfaceContainerDark,
      );
}
