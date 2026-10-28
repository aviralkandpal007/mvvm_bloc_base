import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TBottomSheetTheme {
  TBottomSheetTheme._();

  static BottomSheetThemeData get lightBottomSheetTheme => BottomSheetThemeData(
    backgroundColor: TAppColor.surfaceLight,
    surfaceTintColor: Colors.transparent,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
  static BottomSheetThemeData get darkBottomSheetTheme => BottomSheetThemeData(
    backgroundColor: TAppColor.surfaceContainerDark,
    surfaceTintColor: Colors.transparent,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}
