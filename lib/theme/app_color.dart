import 'package:flutter/material.dart';

/// Shared semantic colors for component themes.
///
/// Prefer these tokens over repeating raw color values in component modules.
class TAppColor {
  TAppColor._();

  // Brand colors.
  static Color get primary => Color(0xFF2563EB);
  static Color get primaryLight => Color(0xFF60A5FA);
  static Color get primaryDark => Color(0xFF1D4ED8);
  static Color get onPrimaryLight => Colors.white;
  static Color get onPrimaryDark => Color(0xFF0F172A);
  static Color get primaryContainerLight => Color(0xFFDBEAFE);
  static Color get primaryContainerDark => Color(0xFF1E3A5F);
  static Color get onPrimaryContainerLight => Color(0xFF1E3A8A);
  static Color get onPrimaryContainerDark => Color(0xFFBFDBFE);

  // Text and icon colors.
  static Color get textPrimaryLight => Color(0xFF0F172A);
  static Color get textSecondaryLight => Color(0xFF334155);
  static Color get textMutedLight => Color(0xFF64748B);
  static Color get textHintLight => Color(0xFF94A3B8);
  static Color get textPrimaryDark => Color(0xFFF8FAFC);
  static Color get textSecondaryDark => Color(0xFFCBD5E1);
  static Color get textMutedDark => Color(0xFF94A3B8);
  static Color get textHintDark => Color(0xFF64748B);

  // Page, container and component surfaces.
  static Color get backgroundLight => Color(0xFFF8FAFC);
  static Color get backgroundDark => Color(0xFF0B1120);
  static Color get surfaceLight => Colors.white;
  static Color get surfaceDark => Color(0xFF111827);
  static Color get surfaceContainerLight => Color(0xFFF1F5F9);
  static Color get surfaceContainerDark => Color(0xFF182235);
  static Color get surfaceContainerHighLight => Color(0xFFEFF6FF);
  static Color get surfaceContainerHighDark => Color(0xFF1E293B);
  static Color get surfaceAccentLight => Color(0xFFEFF6FF);
  static Color get onSurfaceLight => textPrimaryLight;
  static Color get onSurfaceDark => textPrimaryDark;

  // Borders, dividers, disabled and feedback states.
  static Color get outlineLight => Color(0xFFCBD5E1);
  static Color get outlineDark => Color(0xFF475569);
  static Color get outlineVariantLight => Color(0xFFE2E8F0);
  static Color get outlineVariantDark => Color(0xFF334155);
  static Color get disabledLight => Color(0xFFE2E8F0);
  static Color get disabledDark => Color(0xFF334155);
  static Color get errorLight => Color(0xFFDC2626);
  static Color get errorDark => Color(0xFFF87171);
  static Color get onErrorLight => Colors.white;
  static Color get onErrorDark => Color(0xFF450A0A);
  static Color get errorTextLight => Color(0xFFB91C1C);
  static Color get errorTextDark => Color(0xFFFCA5A5);
  static Color get inverseSurface => Color(0xFF1E293B);
  static Color get inverseOnSurface => Color(0xFFF8FAFC);

  // Focus, selection and elevation effects.
  static Color get focusLight => primary;
  static Color get focusDark => primaryLight;
  static Color get selectionLight => Color(0x332563EB);
  static Color get selectionDark => Color(0x5560A5FA);
  static Color get shadowLight => Color(0x140F172A);
  static Color get shadowDark => Color(0x66000000);
  static Color get sliderOverlayLight => Color(0x1F2563EB);
  static Color get sliderOverlayDark => Color(0x3360A5FA);
}
