import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TNavigationRailTheme {
  TNavigationRailTheme._();

  static NavigationRailThemeData get lightNavigationRailTheme =>
      NavigationRailThemeData(
        backgroundColor: TAppColor.textPrimaryDark,
        indicatorColor: TAppColor.primaryContainerLight,
        minWidth: 72,
        elevation: 0,
      );
  static NavigationRailThemeData get darkNavigationRailTheme =>
      NavigationRailThemeData(
        backgroundColor: TAppColor.surfaceDark,
        indicatorColor: TAppColor.primaryContainerDark,
        minWidth: 72,
        elevation: 0,
      );
}
