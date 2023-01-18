import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../preferences.dart';

export 'dark_theme.dart';
export 'light_theme.dart';

/// List all theme type available in app
enum AppTheme {
  ///
  blueLight,

  ///
  blueDark,

  // ///
  // greenLight,

  // ///
  // greenDark,
}

/// Allow to convert from [String] to enum [AppTheme]
/// And convert from enum to String
class AppThemeConverter {
  /// Converting enum [AppTheme] to String value,
  ///
  /// For example:
  ///
  /// ```dart
  /// var theme = AppTheme.blueDark;
  /// AppThemeConverter.convertToString(theme);
  /// ```
  /// result: **blueDark**
  ///
  static String convertToString(AppTheme theme) => describeEnum(theme);

  /// Converting from String to Enum
  static AppTheme? fromString(String theme) {
    switch (theme) {
      case 'blueLight':
        return AppTheme.blueLight;
      case 'blueDark':
        return AppTheme.blueDark;
      // case 'greenight':
      //   return AppTheme.greenLight;
      // case 'greenDark':
      //   return AppTheme.greenDark;

      default:
        return null;
    }
  }
}

// ignore: avoid_classes_with_only_static_members
/// All Data theme
class AppThemeData {
  /// Getting data [ThemeData] with type `Map<AppTheme, ThemeData>`
  static final datas = {
    AppTheme.blueLight: MaterialLightTheme.data,
    AppTheme.blueDark: MaterialDarkTheme.data(const Color(0xFF286782)),
    // AppTheme.greenLight: MaterialLightTheme.data.copyWith(
    //   primaryColor: Colors.green,
    // ),
    // AppTheme.greenDark: MaterialDarkTheme.data.copyWith(
    //   primaryColor: Colors.green,
    // ),
  };
}
