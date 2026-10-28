import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TSearchViewTheme {
  TSearchViewTheme._();

  static SearchViewThemeData get lightSearchViewTheme => SearchViewThemeData(
    backgroundColor: TAppColor.textPrimaryDark,
    headerTextStyle: TextStyle(color: TAppColor.textPrimaryLight),
    headerHintStyle: TextStyle(color: TAppColor.textMutedLight),
  );
  static SearchViewThemeData get darkSearchViewTheme => SearchViewThemeData(
    backgroundColor: TAppColor.surfaceDark,
    headerTextStyle: TextStyle(color: TAppColor.textPrimaryDark),
    headerHintStyle: TextStyle(color: TAppColor.textHintLight),
  );
}
