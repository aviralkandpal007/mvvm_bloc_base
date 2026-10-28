import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TListTileTheme {
  TListTileTheme._();

  static ListTileThemeData get lightListTileTheme => ListTileThemeData(
    iconColor: TAppColor.outlineDark,
    textColor: TAppColor.textPrimaryLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
  static ListTileThemeData get darkListTileTheme => ListTileThemeData(
    iconColor: TAppColor.outlineLight,
    textColor: TAppColor.textPrimaryDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}
