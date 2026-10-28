import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TPopupMenuTheme {
  TPopupMenuTheme._();

  static PopupMenuThemeData get lightPopupMenuTheme => PopupMenuThemeData(
    color: TAppColor.surfaceLight,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
  static PopupMenuThemeData get darkPopupMenuTheme => PopupMenuThemeData(
    color: TAppColor.surfaceContainerDark,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}
