# Theme System Guide

This document explains the theme structure, what can be customized, how the
light and dark themes are connected, and how to extend the system safely.

## Directory layout

```text
lib/theme/
├── app_theme.dart
├── app_color.dart              # Shared semantic color tokens
├── theme.md
└── component/
    ├── app_bar_theme.dart
    ├── button_theme.dart
    ├── floating_action_button_theme.dart
    ├── navigation_bar_theme.dart
    ├── date_picker_theme.dart
    ├── ... one focused file per component
```


`app_theme.dart` stays at the theme root because it is the single composition
point used by `MaterialApp`. The individual component definitions live under
`component/` and are split by responsibility. Every module class has a private
constructor and static getters, so no class instances are needed. Getters make
the values simple to edit and allow updated Dart source to be picked up by
Flutter hot reload when the widget tree rebuilds. A getter by itself does not
cause runtime state changes to notify/rebuild the app.

## Flutter SDK reference and coverage

The component inventory here is based on the `ThemeData` constructor and
component theme data classes in the Flutter SDK used by this project (Flutter
3.47.8, recorded in `.dart_tool/version`). Flutter adds and deprecates theme
properties over time, so revisit the SDK's `ThemeData` API when upgrading.

Flutter has two related customization layers:

1. **App-wide `ThemeData` configuration** covers brightness, `ColorScheme`,
   typography and iconography, visual density, tap target size, page
   transitions, platform behavior, splash behavior, elevation overlays,
   extensions, Cupertino overrides, and the component themes below.
2. **Component theme data** supplies defaults for families of Material
   components such as cards, text fields, navigation, buttons, and pickers.

The current composition explicitly connects all 46 component theme slots
available to `ThemeData` in the referenced SDK, for both light and dark themes.
Some slots (such as action-icon builders and legacy `ButtonThemeData`) currently
use Flutter defaults rather than custom overrides. Flutter also derives many
component defaults from `ColorScheme`, `TextTheme`, and Material 3, so
explicitly setting every possible property inside each theme data class is not
required.

Theme values are defaults. A widget's own non-null property or a local
`Theme`/component-theme widget lower in the tree can override them. Prefer the
central defaults for shared styling; reserve local overrides for intentional,
screen-specific exceptions.

## Module inventory

| File | Class | Responsibility |
| --- | --- | --- |
| File | Class | Responsibility |
| --- | --- | --- |
| `app_theme.dart` | `TAppTheme` | Composes `lightTheme` and `darkTheme` and is attached to `MaterialApp`. |
| `app_color.dart` | `TAppColor` | Reusable brand, text, surface, outline, disabled and error color tokens for components. |
| `component/app_bar_theme.dart` | `TAppBarTheme` | One focused component theme, with light and dark getters. |
| `component/badge_theme.dart` | `TBadgeTheme` | One focused component theme, with light and dark getters. |
| `component/banner_theme.dart` | `TMaterialBannerTheme` | One focused component theme, with light and dark getters. |
| `component/floating_action_button_theme.dart` | `TFloatingActionButtonTheme` | Floating action button colors, elevation and shape. |
| `component/bottom_navigation_bar_theme.dart` | `TBottomNavigationBarTheme` | Bottom navigation colors, labels and elevation. |
| `component/bottom_app_bar_theme.dart` | `TBottomAppBarTheme` | One focused component theme, with light and dark getters. |
| `component/bottom_navigation_bar_theme.dart` | `TBottomNavigationBarTheme` | One focused component theme, with light and dark getters. |
| `component/bottom_sheet_theme.dart` | `TBottomSheetTheme` | One focused component theme, with light and dark getters. |
| `component/button_theme.dart` | `TButtonTheme` | One focused component theme, with light and dark getters. |
| `component/card_theme.dart` | `TCardTheme` | One focused component theme, with light and dark getters. |
| `component/carousel_view_theme.dart` | `TCarouselViewTheme` | One focused component theme, with light and dark getters. |
| `component/checkbox_theme.dart` | `TCheckboxTheme` | One focused component theme, with light and dark getters. |
| `component/chip_theme.dart` | `TChipTheme` | One focused component theme, with light and dark getters. |
| `component/color_theme.dart` | `TColorTheme` | Builds Material color schemes and scaffold backgrounds from `TAppColor`. |
| `component/data_table_theme.dart` | `TDataTableTheme` | One focused component theme, with light and dark getters. |
| `component/date_picker_theme.dart` | `TDatePickerTheme` | One focused component theme, with light and dark getters. |
| `component/dialog_theme.dart` | `TDialogTheme` | One focused component theme, with light and dark getters. |
| `component/divider_theme.dart` | `TDividerTheme` | One focused component theme, with light and dark getters. |
| `component/drawer_theme.dart` | `TDrawerTheme` | One focused component theme, with light and dark getters. |
| `component/dropdown_menu_theme.dart` | `TDropdownMenuTheme` | One focused component theme, with light and dark getters. |
| `component/expansion_tile_theme.dart` | `TExpansionTileTheme` | One focused component theme, with light and dark getters. |
| `component/floating_action_button_theme.dart` | `TFloatingActionButtonTheme` | One focused component theme, with light and dark getters. |
| `component/font_theme.dart` | `TFontTheme` | One focused component theme, with light and dark getters. |
| `component/icon_button_theme.dart` | `TIconButtonTheme` | One focused component theme, with light and dark getters. |
| `component/input_theme.dart` | `TInputTheme` | One focused component theme, with light and dark getters. |
| `component/list_tile_theme.dart` | `TListTileTheme` | One focused component theme, with light and dark getters. |
| `component/menu_bar_theme.dart` | `TMenuBarTheme` | One focused component theme, with light and dark getters. |
| `component/menu_button_theme.dart` | `TMenuButtonTheme` | One focused component theme, with light and dark getters. |
| `component/menu_theme.dart` | `TMenuTheme` | One focused component theme, with light and dark getters. |
| `component/navigation_bar_theme.dart` | `TNavigationBarTheme` | One focused component theme, with light and dark getters. |
| `component/navigation_drawer_theme.dart` | `TNavigationDrawerTheme` | One focused component theme, with light and dark getters. |
| `component/navigation_rail_theme.dart` | `TNavigationRailTheme` | One focused component theme, with light and dark getters. |
| `component/popup_menu_theme.dart` | `TPopupMenuTheme` | One focused component theme, with light and dark getters. |
| `component/progress_indicator_theme.dart` | `TProgressIndicatorTheme` | One focused component theme, with light and dark getters. |
| `component/radio_theme.dart` | `TRadioTheme` | One focused component theme, with light and dark getters. |
| `component/scrollbar_theme.dart` | `TScrollbarTheme` | One focused component theme, with light and dark getters. |
| `component/search_bar_theme.dart` | `TSearchBarTheme` | One focused component theme, with light and dark getters. |
| `component/search_view_theme.dart` | `TSearchViewTheme` | One focused component theme, with light and dark getters. |
| `component/segmented_button_theme.dart` | `TSegmentedButtonTheme` | One focused component theme, with light and dark getters. |
| `component/slider_theme.dart` | `TSliderTheme` | One focused component theme, with light and dark getters. |
| `component/snack_bar_theme.dart` | `TSnackBarTheme` | One focused component theme, with light and dark getters. |
| `component/switch_theme.dart` | `TSwitchTheme` | One focused component theme, with light and dark getters. |
| `component/tab_bar_theme.dart` | `TTabBarTheme` | One focused component theme, with light and dark getters. |
| `component/time_picker_theme.dart` | `TTimePickerTheme` | One focused component theme, with light and dark getters. |
| `component/toggle_buttons_theme.dart` | `TToggleButtonsTheme` | One focused component theme, with light and dark getters. |
| `component/tooltip_theme.dart` | `TTooltipTheme` | One focused component theme, with light and dark getters. |

## Light and dark mode

`lib/main.dart` uses the composition module as follows:

```dart
MaterialApp(
  theme: TAppTheme.lightTheme,
  darkTheme: TAppTheme.darkTheme,
  themeMode: ThemeMode.system,
  // home: ...
)
```

`ThemeMode.system` follows the device appearance. Set `ThemeMode.light` or
`ThemeMode.dark` to force a theme. For a user-controlled setting, store the
selection in application state and rebuild `MaterialApp` with the selected
mode. Getter-based theme definitions are not a substitute for notifying Flutter
when app state changes.

## Using themes in widgets

Read semantic roles from the current `BuildContext`, rather than hard-coding
different colors in individual screens:

```dart
final colors = Theme.of(context).colorScheme;
final textStyles = Theme.of(context).textTheme;

Container(
  color: colors.surface,
  child: Text('Hello', style: textStyles.titleLarge),
)
```

Useful semantic color roles include `primary`, `onPrimary`, `surface`,
`onSurface`, `secondary`, `error`, and `outline`. Text roles include
`bodyMedium`, `titleLarge`, and `headlineMedium`. App bars, standard buttons,
fields, and other Material components pick up their defaults from the active
theme automatically.

## Detailed customization guide

### Colors — `TAppColor` and `TColorTheme`

`app_color.dart` defines shared semantic color getters such as `primary`,
`textPrimaryLight`, `backgroundLight`, `surfaceDark`, `outlineLight`, and
`errorLight`. Component modules import `TAppColor` and use these tokens instead
of repeating raw hex values. Change a shared token once to update the related
component styling. Use distinct `...Light` and `...Dark` tokens when contrast
needs to differ by appearance. `TColorTheme` builds the app's
`lightColorScheme` and `darkColorScheme` from the shared brand colors with
`ColorScheme.fromSeed`; continue using semantic roles from the color scheme in
screens.

### Typography — `TFontTheme`

`lightTextTheme` and `darkTextTheme` define matching Material text roles with
foreground colors appropriate to each brightness. Sizes and weights are
centralized there. `fontFamily` is currently `null`, meaning Flutter uses its
platform default. For a custom font, register assets under `flutter: fonts:` in
`pubspec.yaml`, return that family from the getter, and apply it consistently to
both text themes.

### App bars and buttons

`TAppBarTheme` sets shared app-bar colors, icons, title typography, elevation
and toolbar behavior. `TButtonTheme` sets shape, sizing, and states/colors for
the major button families. Use standard Material button widgets to receive
these defaults. Components like floating action buttons and segmented buttons
have their own values in `TDatePickerTheme`, `TTimePickerTheme`, `TFloatingActionButtonTheme`, `TCarouselViewTheme`, and `TSegmentedButtonTheme`.

### Inputs — `TInputTheme`

This module centralizes field fill, content padding, label/hint/helper/error
colors, enabled/focused/error borders, and text selection colors. Individual
fields can still provide their own `InputDecoration` when they need a distinct
label, hint, icon, or validation message; shared shape/color stays centralized.

### Component-specific styling

Every component now has its own module under `component/`. For example, edit
`card_theme.dart` for card shape, `switch_theme.dart` for switch colors,
`navigation_bar_theme.dart` for its indicator, `chip_theme.dart` for chip
styling, `search_bar_theme.dart` for search appearance, or
`floating_action_button_theme.dart` for the FAB. Each file provides separate
light and dark getters for that component.

### Inherited and deprecated settings

Some app-wide or legacy fields intentionally use Flutter defaults rather than
duplicate values. Examples include deprecated standalone colors such as
`dialogBackgroundColor` and legacy `ButtonBarThemeData`. Prefer current
component APIs such as `DialogThemeData.backgroundColor`. App-wide platform
transitions, density, and tap target sizing are configured in `TAppTheme`, not
duplicated in visual component modules. `ActionIconThemeData` currently uses
default builders; only add icon builders there if replacing system back, close,
or drawer icons is an intentional product requirement.

## Adding or changing a component theme

1. Find the component's `ThemeData` field and supported theme-data type in the
   Flutter SDK version used by the project.
2. Add or update the corresponding light and dark static getters in the most
   relevant file under `lib/theme/component/`. For a new category, add a
   clearly named component file and a `T...Theme` class with a private
   constructor.
3. Import the component module in `lib/theme/app_theme.dart` and assign both
   getters in the matching `ThemeData` constructors.
4. Add the file/class/responsibility to the inventory table in this guide.
5. Run `dart format lib/theme` and `flutter analyze`; run tests if widget
   behavior or app rendering changed.

Keep app-wide composition in `TAppTheme`, component defaults in `component/`,
and stateful appearance preferences in app state rather than static globals.
