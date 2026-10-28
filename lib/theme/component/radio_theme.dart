import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TRadioTheme {
  TRadioTheme._();

  static RadioThemeData get lightRadioTheme =>
      RadioThemeData(fillColor: WidgetStatePropertyAll(TAppColor.primary));
  static RadioThemeData get darkRadioTheme =>
      RadioThemeData(fillColor: WidgetStatePropertyAll(TAppColor.primaryLight));
}
