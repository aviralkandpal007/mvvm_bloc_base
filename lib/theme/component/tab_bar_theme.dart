import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for tab bars.
class TTabBarTheme {
  TTabBarTheme._();

  static TabBarThemeData get lightTabBarTheme => TabBarThemeData(
    labelColor: TAppColor.primaryDark,
    unselectedLabelColor: TAppColor.textMutedLight,
    indicatorColor: TAppColor.primary,
    dividerColor: TAppColor.outlineVariantLight,
    indicatorSize: TabBarIndicatorSize.label,
  );
  static TabBarThemeData get darkTabBarTheme => TabBarThemeData(
    labelColor: TAppColor.onPrimaryContainerDark,
    unselectedLabelColor: TAppColor.textHintLight,
    indicatorColor: TAppColor.primaryLight,
    dividerColor: TAppColor.outlineVariantDark,
    indicatorSize: TabBarIndicatorSize.label,
  );
}
