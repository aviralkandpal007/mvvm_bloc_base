import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TChipTheme {
  TChipTheme._();

  static ChipThemeData get lightChipTheme => ChipThemeData(
    backgroundColor: TAppColor.surfaceContainerLight,
    selectedColor: TAppColor.primaryContainerLight,
    secondarySelectedColor: TAppColor.primaryContainerLight,
    disabledColor: TAppColor.outlineVariantLight,
    deleteIconColor: TAppColor.textMutedLight,
    checkmarkColor: TAppColor.primaryDark,
    side: BorderSide(color: TAppColor.outlineVariantLight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    labelStyle: TextStyle(color: TAppColor.outlineVariantDark),
  );
  static ChipThemeData get darkChipTheme => ChipThemeData(
    backgroundColor: TAppColor.surfaceContainerHighDark,
    selectedColor: TAppColor.primaryContainerDark,
    secondarySelectedColor: TAppColor.primaryContainerDark,
    disabledColor: TAppColor.outlineVariantDark,
    deleteIconColor: TAppColor.textHintLight,
    checkmarkColor: TAppColor.onPrimaryContainerDark,
    side: BorderSide(color: TAppColor.outlineVariantDark),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    labelStyle: TextStyle(color: TAppColor.outlineLight),
  );
}
