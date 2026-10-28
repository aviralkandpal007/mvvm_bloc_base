import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TSnackBarTheme {
  TSnackBarTheme._();

  static SnackBarThemeData get lightSnackBarTheme => SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: TAppColor.surfaceContainerHighDark,
    contentTextStyle: TextStyle(color: TAppColor.textPrimaryDark),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
  static SnackBarThemeData get darkSnackBarTheme => SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: TAppColor.outlineVariantLight,
    contentTextStyle: TextStyle(color: TAppColor.textPrimaryLight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}
