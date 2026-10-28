import 'package:flutter/material.dart';

import '../app_color.dart';

/// Text field borders, fill, labels, hints and selection handles.
class TInputTheme {
  TInputTheme._();

  static OutlineInputBorder get _lightBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: TAppColor.outlineLight),
  );
  static OutlineInputBorder get _lightFocusedBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: TAppColor.primary, width: 2),
  );
  static OutlineInputBorder get _lightErrorBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: TAppColor.errorLight),
  );
  static OutlineInputBorder get _darkBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: TAppColor.outlineDark),
  );
  static OutlineInputBorder get _darkFocusedBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: TAppColor.primaryLight, width: 2),
  );
  static OutlineInputBorder get _darkErrorBorder => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: TAppColor.errorDark),
  );

  static InputDecorationThemeData get lightInputDecorationTheme =>
      InputDecorationThemeData(
        filled: true,
        fillColor: TAppColor.surfaceLight,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: TAppColor.outlineDark),
        floatingLabelStyle: TextStyle(color: TAppColor.primaryDark),
        hintStyle: TextStyle(color: TAppColor.textHintLight),
        helperStyle: TextStyle(color: TAppColor.textMutedLight),
        errorStyle: TextStyle(color: TAppColor.errorTextLight),
        enabledBorder: _lightBorder,
        border: _lightBorder,
        focusedBorder: _lightFocusedBorder,
        errorBorder: _lightErrorBorder,
        focusedErrorBorder: _lightErrorBorder,
      );

  static InputDecorationThemeData get darkInputDecorationTheme =>
      InputDecorationThemeData(
        filled: true,
        fillColor: TAppColor.surfaceContainerDark,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: TAppColor.outlineLight),
        floatingLabelStyle: TextStyle(color: TAppColor.primaryLight),
        hintStyle: TextStyle(color: TAppColor.textMutedLight),
        helperStyle: TextStyle(color: TAppColor.textHintLight),
        errorStyle: TextStyle(color: TAppColor.errorTextDark),
        enabledBorder: _darkBorder,
        border: _darkBorder,
        focusedBorder: _darkFocusedBorder,
        errorBorder: _darkErrorBorder,
        focusedErrorBorder: _darkErrorBorder,
      );

  static TextSelectionThemeData get lightTextSelectionTheme =>
      TextSelectionThemeData(
        cursorColor: TAppColor.primary,
        selectionColor: TAppColor.selectionLight,
        selectionHandleColor: TAppColor.primary,
      );
  static TextSelectionThemeData get darkTextSelectionTheme =>
      TextSelectionThemeData(
        cursorColor: TAppColor.primaryLight,
        selectionColor: TAppColor.selectionDark,
        selectionHandleColor: TAppColor.primaryLight,
      );
}
