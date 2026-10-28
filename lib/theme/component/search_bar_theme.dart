import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TSearchBarTheme {
  TSearchBarTheme._();

  static SearchBarThemeData get lightSearchBarTheme => SearchBarThemeData(
    elevation: WidgetStatePropertyAll(0),
    backgroundColor: WidgetStatePropertyAll(TAppColor.surfaceContainerLight),
    hintStyle: WidgetStatePropertyAll(
      TextStyle(color: TAppColor.textMutedLight),
    ),
    textStyle: WidgetStatePropertyAll(
      TextStyle(color: TAppColor.textPrimaryLight),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
    ),
  );
  static SearchBarThemeData get darkSearchBarTheme => SearchBarThemeData(
    elevation: WidgetStatePropertyAll(0),
    backgroundColor: WidgetStatePropertyAll(TAppColor.surfaceContainerHighDark),
    hintStyle: WidgetStatePropertyAll(
      TextStyle(color: TAppColor.textHintLight),
    ),
    textStyle: WidgetStatePropertyAll(
      TextStyle(color: TAppColor.textPrimaryDark),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
    ),
  );
}
