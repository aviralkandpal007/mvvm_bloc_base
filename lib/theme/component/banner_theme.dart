import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TMaterialBannerTheme {
  TMaterialBannerTheme._();

  static MaterialBannerThemeData get lightMaterialBannerTheme =>
      MaterialBannerThemeData(
        backgroundColor: TAppColor.surfaceAccentLight,
        contentTextStyle: TextStyle(color: TAppColor.onPrimaryContainerLight),
      );
  static MaterialBannerThemeData get darkMaterialBannerTheme =>
      MaterialBannerThemeData(
        backgroundColor: TAppColor.primaryContainerDark,
        contentTextStyle: TextStyle(color: TAppColor.primaryContainerLight),
      );
}
