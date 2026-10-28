import 'package:flutter/material.dart';

import '../app_color.dart';

/// AppBar styling shared by every screen in the application.
class TAppBarTheme {
  TAppBarTheme._();

  static AppBarThemeData get lightAppBarTheme => AppBarThemeData(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: TAppColor.textPrimaryDark,
    foregroundColor: TAppColor.textPrimaryLight,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: TAppColor.outlineVariantDark),
    actionsIconTheme: IconThemeData(color: TAppColor.outlineVariantDark),
    titleTextStyle: TextStyle(
      color: TAppColor.textPrimaryLight,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );

  static AppBarThemeData get darkAppBarTheme => AppBarThemeData(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: TAppColor.surfaceDark,
    foregroundColor: TAppColor.textPrimaryDark,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: TAppColor.outlineLight),
    actionsIconTheme: IconThemeData(color: TAppColor.outlineLight),
    titleTextStyle: TextStyle(
      color: TAppColor.textPrimaryDark,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );
}
