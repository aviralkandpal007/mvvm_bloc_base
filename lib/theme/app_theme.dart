import 'package:flutter/material.dart';

import 'component/tooltip_theme.dart';
import 'component/switch_theme.dart';
import 'component/snack_bar_theme.dart';
import 'component/slider_theme.dart';
import 'component/scrollbar_theme.dart';
import 'component/radio_theme.dart';
import 'component/progress_indicator_theme.dart';
import 'component/popup_menu_theme.dart';
import 'component/list_tile_theme.dart';
import 'component/expansion_tile_theme.dart';
import 'component/drawer_theme.dart';
import 'component/divider_theme.dart';
import 'component/dialog_theme.dart';
import 'component/checkbox_theme.dart';
import 'component/card_theme.dart';
import 'component/bottom_sheet_theme.dart';
import 'component/bottom_app_bar_theme.dart';
import 'component/tab_bar_theme.dart';
import 'component/toggle_buttons_theme.dart';
import 'component/time_picker_theme.dart';
import 'component/segmented_button_theme.dart';
import 'component/search_view_theme.dart';
import 'component/search_bar_theme.dart';
import 'component/navigation_rail_theme.dart';
import 'component/navigation_drawer_theme.dart';
import 'component/navigation_bar_theme.dart';
import 'component/menu_theme.dart';
import 'component/menu_button_theme.dart';
import 'component/menu_bar_theme.dart';
import 'component/icon_button_theme.dart';
import 'component/floating_action_button_theme.dart';
import 'component/dropdown_menu_theme.dart';
import 'component/date_picker_theme.dart';
import 'component/data_table_theme.dart';
import 'component/chip_theme.dart';
import 'component/carousel_view_theme.dart';
import 'component/bottom_navigation_bar_theme.dart';
import 'component/banner_theme.dart';
import 'component/badge_theme.dart';
import 'component/app_bar_theme.dart';
import 'component/button_theme.dart';
import 'component/color_theme.dart';
import 'component/font_theme.dart';
import 'component/input_theme.dart';

/// Composes all theme modules into the light and dark themes used by the app.
/// Use [ThemeMode.system] to follow the device appearance setting.
class TAppTheme {
  TAppTheme._();

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: TColorTheme.lightColorScheme,
    scaffoldBackgroundColor: TColorTheme.lightScaffoldBackground,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    textTheme: TFontTheme.lightTextTheme,
    elevatedButtonTheme: TButtonTheme.lightElevatedButtonTheme,
    filledButtonTheme: TButtonTheme.lightFilledButtonTheme,
    outlinedButtonTheme: TButtonTheme.lightOutlinedButtonTheme,
    textButtonTheme: TButtonTheme.lightTextButtonTheme,
    inputDecorationTheme: TInputTheme.lightInputDecorationTheme,
    textSelectionTheme: TInputTheme.lightTextSelectionTheme,
    actionIconTheme: ActionIconThemeData(),
    buttonTheme: ButtonThemeData(),
    cardTheme: TCardTheme.lightCardTheme,
    dialogTheme: TDialogTheme.lightDialogTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    bottomAppBarTheme: TBottomAppBarTheme.lightBottomAppBarTheme,
    dividerTheme: TDividerTheme.lightDividerTheme,
    drawerTheme: TDrawerTheme.lightDrawerTheme,
    listTileTheme: TListTileTheme.lightListTileTheme,
    popupMenuTheme: TPopupMenuTheme.lightPopupMenuTheme,
    snackBarTheme: TSnackBarTheme.lightSnackBarTheme,
    tooltipTheme: TTooltipTheme.lightTooltipTheme,
    bannerTheme: TMaterialBannerTheme.lightMaterialBannerTheme,
    badgeTheme: TBadgeTheme.lightBadgeTheme,
    expansionTileTheme: TExpansionTileTheme.lightExpansionTileTheme,
    progressIndicatorTheme: TProgressIndicatorTheme.lightProgressIndicatorTheme,
    scrollbarTheme: TScrollbarTheme.lightScrollbarTheme,
    dataTableTheme: TDataTableTheme.lightDataTableTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    radioTheme: TRadioTheme.lightRadioTheme,
    switchTheme: TSwitchTheme.lightSwitchTheme,
    sliderTheme: TSliderTheme.lightSliderTheme,
    iconButtonTheme: TIconButtonTheme.lightIconButtonTheme,
    toggleButtonsTheme: TToggleButtonsTheme.lightToggleButtonsTheme,
    bottomNavigationBarTheme:
        TBottomNavigationBarTheme.lightBottomNavigationBarTheme,
    navigationBarTheme: TNavigationBarTheme.lightNavigationBarTheme,
    navigationDrawerTheme: TNavigationDrawerTheme.lightNavigationDrawerTheme,
    navigationRailTheme: TNavigationRailTheme.lightNavigationRailTheme,
    tabBarTheme: TTabBarTheme.lightTabBarTheme,
    chipTheme: TChipTheme.lightChipTheme,
    dropdownMenuTheme: TDropdownMenuTheme.lightDropdownMenuTheme,
    searchBarTheme: TSearchBarTheme.lightSearchBarTheme,
    searchViewTheme: TSearchViewTheme.lightSearchViewTheme,
    menuTheme: TMenuTheme.lightMenuTheme,
    menuBarTheme: TMenuBarTheme.lightMenuBarTheme,
    menuButtonTheme: TMenuButtonTheme.lightMenuButtonTheme,
    datePickerTheme: TDatePickerTheme.lightDatePickerTheme,
    timePickerTheme: TTimePickerTheme.lightTimePickerTheme,
    floatingActionButtonTheme:
        TFloatingActionButtonTheme.lightFloatingActionButtonTheme,
    carouselViewTheme: TCarouselViewTheme.lightCarouselViewTheme,
    segmentedButtonTheme: TSegmentedButtonTheme.lightSegmentedButtonTheme,
    platform: ThemeData.light().platform,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: VisualDensity.standard,
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: TColorTheme.darkColorScheme,
    scaffoldBackgroundColor: TColorTheme.darkScaffoldBackground,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    textTheme: TFontTheme.darkTextTheme,
    elevatedButtonTheme: TButtonTheme.darkElevatedButtonTheme,
    filledButtonTheme: TButtonTheme.darkFilledButtonTheme,
    outlinedButtonTheme: TButtonTheme.darkOutlinedButtonTheme,
    textButtonTheme: TButtonTheme.darkTextButtonTheme,
    inputDecorationTheme: TInputTheme.darkInputDecorationTheme,
    textSelectionTheme: TInputTheme.darkTextSelectionTheme,
    actionIconTheme: ActionIconThemeData(),
    buttonTheme: ButtonThemeData(),
    cardTheme: TCardTheme.darkCardTheme,
    dialogTheme: TDialogTheme.darkDialogTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    bottomAppBarTheme: TBottomAppBarTheme.darkBottomAppBarTheme,
    dividerTheme: TDividerTheme.darkDividerTheme,
    drawerTheme: TDrawerTheme.darkDrawerTheme,
    listTileTheme: TListTileTheme.darkListTileTheme,
    popupMenuTheme: TPopupMenuTheme.darkPopupMenuTheme,
    snackBarTheme: TSnackBarTheme.darkSnackBarTheme,
    tooltipTheme: TTooltipTheme.darkTooltipTheme,
    bannerTheme: TMaterialBannerTheme.darkMaterialBannerTheme,
    badgeTheme: TBadgeTheme.darkBadgeTheme,
    expansionTileTheme: TExpansionTileTheme.darkExpansionTileTheme,
    progressIndicatorTheme: TProgressIndicatorTheme.darkProgressIndicatorTheme,
    scrollbarTheme: TScrollbarTheme.darkScrollbarTheme,
    dataTableTheme: TDataTableTheme.darkDataTableTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    radioTheme: TRadioTheme.darkRadioTheme,
    switchTheme: TSwitchTheme.darkSwitchTheme,
    sliderTheme: TSliderTheme.darkSliderTheme,
    iconButtonTheme: TIconButtonTheme.darkIconButtonTheme,
    toggleButtonsTheme: TToggleButtonsTheme.darkToggleButtonsTheme,
    bottomNavigationBarTheme:
        TBottomNavigationBarTheme.darkBottomNavigationBarTheme,
    navigationBarTheme: TNavigationBarTheme.darkNavigationBarTheme,
    navigationDrawerTheme: TNavigationDrawerTheme.darkNavigationDrawerTheme,
    navigationRailTheme: TNavigationRailTheme.darkNavigationRailTheme,
    tabBarTheme: TTabBarTheme.darkTabBarTheme,
    chipTheme: TChipTheme.darkChipTheme,
    dropdownMenuTheme: TDropdownMenuTheme.darkDropdownMenuTheme,
    searchBarTheme: TSearchBarTheme.darkSearchBarTheme,
    searchViewTheme: TSearchViewTheme.darkSearchViewTheme,
    menuTheme: TMenuTheme.darkMenuTheme,
    menuBarTheme: TMenuBarTheme.darkMenuBarTheme,
    menuButtonTheme: TMenuButtonTheme.darkMenuButtonTheme,
    datePickerTheme: TDatePickerTheme.darkDatePickerTheme,
    timePickerTheme: TTimePickerTheme.darkTimePickerTheme,
    floatingActionButtonTheme:
        TFloatingActionButtonTheme.darkFloatingActionButtonTheme,
    carouselViewTheme: TCarouselViewTheme.darkCarouselViewTheme,
    segmentedButtonTheme: TSegmentedButtonTheme.darkSegmentedButtonTheme,
    platform: ThemeData.dark().platform,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: VisualDensity.standard,
  );
}
