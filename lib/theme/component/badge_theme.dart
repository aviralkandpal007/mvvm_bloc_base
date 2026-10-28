import 'package:flutter/material.dart';

import '../app_color.dart';

/// Light and dark theme defaults for this component.
class TBadgeTheme {
  TBadgeTheme._();

  static BadgeThemeData get lightBadgeTheme => BadgeThemeData(
    backgroundColor: TAppColor.errorLight,
    textColor: TAppColor.onPrimaryLight,
  );
  static BadgeThemeData get darkBadgeTheme => BadgeThemeData(
    backgroundColor: TAppColor.errorDark,
    textColor: TAppColor.onErrorDark,
  );
}
