import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TCheckboxTheme {
  TCheckboxTheme._();

  static CheckboxThemeData get lightCheckboxTheme => CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? TAppColor.primary : null,
    ),
    checkColor: WidgetStatePropertyAll(TAppColor.onPrimaryLight),
    side: BorderSide(color: TAppColor.textHintLight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );
  static CheckboxThemeData get darkCheckboxTheme => CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? TAppColor.primaryLight : null,
    ),
    checkColor: WidgetStatePropertyAll(TAppColor.textPrimaryLight),
    side: BorderSide(color: TAppColor.textMutedLight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );
}
