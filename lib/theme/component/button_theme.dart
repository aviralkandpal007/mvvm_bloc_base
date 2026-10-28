import 'package:flutter/material.dart';

import '../app_color.dart';

/// Material button defaults for light and dark themes.
class TButtonTheme {
  TButtonTheme._();

  static RoundedRectangleBorder get _shape => RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static ButtonStyle get _filledButtonStyle => ElevatedButton.styleFrom(
    minimumSize: Size(64, 48),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    shape: _shape,
    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );
  static ButtonStyle get _outlinedButtonStyle => OutlinedButton.styleFrom(
    minimumSize: Size(64, 48),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    shape: _shape,
    side: BorderSide(color: TAppColor.outlineLight),
    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );
  static ButtonStyle get _textButtonStyle => TextButton.styleFrom(
    minimumSize: Size(48, 44),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    shape: _shape,
    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );

  static ElevatedButtonThemeData get lightElevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: _filledButtonStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(TAppColor.primary),
          foregroundColor: WidgetStatePropertyAll(TAppColor.onPrimaryLight),
        ),
      );
  static ElevatedButtonThemeData get darkElevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: _filledButtonStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(TAppColor.primaryLight),
          foregroundColor: WidgetStatePropertyAll(TAppColor.textPrimaryLight),
        ),
      );

  static FilledButtonThemeData get lightFilledButtonTheme =>
      FilledButtonThemeData(
        style: _filledButtonStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(TAppColor.primary),
          foregroundColor: WidgetStatePropertyAll(TAppColor.onPrimaryLight),
        ),
      );

  static FilledButtonThemeData get darkFilledButtonTheme =>
      FilledButtonThemeData(
        style: _filledButtonStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(TAppColor.primaryLight),
          foregroundColor: WidgetStatePropertyAll(TAppColor.textPrimaryLight),
        ),
      );
  static OutlinedButtonThemeData get lightOutlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: _outlinedButtonStyle.copyWith(
          foregroundColor: WidgetStatePropertyAll(TAppColor.primaryDark),
        ),
      );
  static OutlinedButtonThemeData get darkOutlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: _outlinedButtonStyle.copyWith(
          foregroundColor: WidgetStatePropertyAll(
            TAppColor.onPrimaryContainerDark,
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: TAppColor.outlineDark),
          ),
        ),
      );
  static TextButtonThemeData get lightTextButtonTheme => TextButtonThemeData(
    style: _textButtonStyle.copyWith(
      foregroundColor: WidgetStatePropertyAll(TAppColor.primaryDark),
    ),
  );
  static TextButtonThemeData get darkTextButtonTheme => TextButtonThemeData(
    style: _textButtonStyle.copyWith(
      foregroundColor: WidgetStatePropertyAll(TAppColor.onPrimaryContainerDark),
    ),
  );
}
