import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TDialogTheme {
  TDialogTheme._();

  static DialogThemeData get lightDialogTheme => DialogThemeData(
    backgroundColor: TAppColor.surfaceLight,
    surfaceTintColor: Colors.transparent,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
  static DialogThemeData get darkDialogTheme => DialogThemeData(
    backgroundColor: TAppColor.surfaceContainerDark,
    surfaceTintColor: Colors.transparent,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
}
