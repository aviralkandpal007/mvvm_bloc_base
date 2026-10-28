import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TNavigationBarTheme {
  TNavigationBarTheme._();

  static NavigationBarThemeData get lightNavigationBarTheme =>
      NavigationBarThemeData(
        height: 72,
        backgroundColor: TAppColor.surfaceContainerLight,
        indicatorColor: TAppColor.primaryContainerLight,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      );
  static NavigationBarThemeData get darkNavigationBarTheme =>
      NavigationBarThemeData(
        height: 72,
        backgroundColor: TAppColor.surfaceDark,
        indicatorColor: TAppColor.primaryContainerDark,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      );
}
