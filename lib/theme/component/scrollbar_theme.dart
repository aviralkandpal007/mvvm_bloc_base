import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TScrollbarTheme {
  TScrollbarTheme._();

  static ScrollbarThemeData get lightScrollbarTheme => ScrollbarThemeData(
    thumbVisibility: WidgetStatePropertyAll(false),
    thickness: WidgetStatePropertyAll(6),
    radius: Radius.circular(8),
    thumbColor: WidgetStatePropertyAll(TAppColor.textHintLight),
  );
  static ScrollbarThemeData get darkScrollbarTheme => ScrollbarThemeData(
    thumbVisibility: WidgetStatePropertyAll(false),
    thickness: WidgetStatePropertyAll(6),
    radius: Radius.circular(8),
    thumbColor: WidgetStatePropertyAll(TAppColor.textMutedLight),
  );
}
