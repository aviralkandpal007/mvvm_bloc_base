import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TDrawerTheme {
  TDrawerTheme._();

  static DrawerThemeData get lightDrawerTheme => DrawerThemeData(
    backgroundColor: TAppColor.textPrimaryDark,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
    ),
  );
  static DrawerThemeData get darkDrawerTheme => DrawerThemeData(
    backgroundColor: TAppColor.surfaceDark,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
    ),
  );
}
