import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TCardTheme {
  TCardTheme._();

  static CardThemeData get lightCardTheme => CardThemeData(
    color: TAppColor.surfaceLight,
    surfaceTintColor: Colors.transparent,
    shadowColor: TAppColor.shadowLight,
    elevation: 1,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );
  static CardThemeData get darkCardTheme => CardThemeData(
    color: TAppColor.surfaceContainerDark,
    surfaceTintColor: Colors.transparent,
    shadowColor: TAppColor.shadowDark,
    elevation: 1,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );
}
