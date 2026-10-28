import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TSegmentedButtonTheme {
  TSegmentedButtonTheme._();

  static SegmentedButtonThemeData get lightSegmentedButtonTheme =>
      SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(TAppColor.outlineVariantDark),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? TAppColor.primaryContainerLight
                : Colors.transparent,
          ),
        ),
      );
  static SegmentedButtonThemeData get darkSegmentedButtonTheme =>
      SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(TAppColor.outlineLight),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? TAppColor.primaryContainerDark
                : Colors.transparent,
          ),
        ),
      );
}
