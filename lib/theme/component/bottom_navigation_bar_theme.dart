import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TBottomNavigationBarTheme {
  TBottomNavigationBarTheme._();

  static BottomNavigationBarThemeData get lightBottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: TAppColor.surfaceLight,
        selectedItemColor: TAppColor.primaryDark,
        unselectedItemColor: TAppColor.textMutedLight,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 2,
      );
  static BottomNavigationBarThemeData get darkBottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: TAppColor.surfaceDark,
        selectedItemColor: TAppColor.onPrimaryContainerDark,
        unselectedItemColor: TAppColor.textHintLight,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 2,
      );
}
