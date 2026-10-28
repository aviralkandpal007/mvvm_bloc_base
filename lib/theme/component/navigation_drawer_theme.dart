import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TNavigationDrawerTheme {
  TNavigationDrawerTheme._();

  static NavigationDrawerThemeData get lightNavigationDrawerTheme =>
      NavigationDrawerThemeData(
        backgroundColor: TAppColor.textPrimaryDark,
        indicatorColor: TAppColor.primaryContainerLight,
        elevation: 1,
        tileHeight: 56,
        surfaceTintColor: Colors.transparent,
      );
  static NavigationDrawerThemeData get darkNavigationDrawerTheme =>
      NavigationDrawerThemeData(
        backgroundColor: TAppColor.surfaceDark,
        indicatorColor: TAppColor.primaryContainerDark,
        elevation: 1,
        tileHeight: 56,
        surfaceTintColor: Colors.transparent,
      );
}
