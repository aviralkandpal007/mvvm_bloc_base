import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark defaults for this component.
class TSliderTheme {
  TSliderTheme._();

  static SliderThemeData get lightSliderTheme => SliderThemeData(
    activeTrackColor: TAppColor.primary,
    inactiveTrackColor: TAppColor.primaryContainerLight,
    thumbColor: TAppColor.primary,
    overlayColor: TAppColor.sliderOverlayLight,
    trackHeight: 4,
    thumbSize: WidgetStatePropertyAll(Size(20, 20)),
  );
  static SliderThemeData get darkSliderTheme => SliderThemeData(
    activeTrackColor: TAppColor.primaryLight,
    inactiveTrackColor: TAppColor.outlineVariantDark,
    thumbColor: TAppColor.primaryLight,
    overlayColor: TAppColor.sliderOverlayDark,
    trackHeight: 4,
    thumbSize: WidgetStatePropertyAll(Size(20, 20)),
  );
}
