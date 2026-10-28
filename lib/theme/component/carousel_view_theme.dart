import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TCarouselViewTheme {
  TCarouselViewTheme._();

  static CarouselViewThemeData get lightCarouselViewTheme =>
      CarouselViewThemeData(
        backgroundColor: TAppColor.surfaceAccentLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      );
  static CarouselViewThemeData get darkCarouselViewTheme =>
      CarouselViewThemeData(
        backgroundColor: TAppColor.surfaceContainerHighDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      );
}
