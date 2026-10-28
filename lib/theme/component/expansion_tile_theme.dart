import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TExpansionTileTheme {
  TExpansionTileTheme._();

  static ExpansionTileThemeData get lightExpansionTileTheme =>
      ExpansionTileThemeData(
        iconColor: TAppColor.outlineDark,
        collapsedIconColor: TAppColor.textMutedLight,
        textColor: TAppColor.textPrimaryLight,
        collapsedTextColor: TAppColor.outlineVariantDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      );
  static ExpansionTileThemeData get darkExpansionTileTheme =>
      ExpansionTileThemeData(
        iconColor: TAppColor.outlineLight,
        collapsedIconColor: TAppColor.textHintLight,
        textColor: TAppColor.textPrimaryDark,
        collapsedTextColor: TAppColor.outlineLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      );
}
