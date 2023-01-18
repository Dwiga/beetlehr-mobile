import 'package:flutter/material.dart';

import '../dimens.dart';

// ignore: avoid_classes_with_only_static_members
/// Base of darkTheme
class MaterialDarkTheme {
  /// Get Theme Data
  static ThemeData data(Color primaryColor) => ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        cardTheme: card,
//        textTheme: text,
        inputDecorationTheme: inputDecoration,
      );

  /// Card theme
  static CardTheme card = CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        side: BorderSide.none,
      ));

  /// Text Theme
  static TextTheme text = const TextTheme(
    // Use for body text
    bodyText1: TextStyle(
      fontSize: Dimens.dp12,
    ),
    bodyText2: TextStyle(
      fontSize: Dimens.dp12,
    ),
    // Use for heading text
    headline5: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Dimens.dp20,
    ),
    // Use for title text
    headline6: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Dimens.dp16,
    ),
    // Use for sub title text
    subtitle1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Dimens.dp14,
    ),
    button: TextStyle(
      fontSize: Dimens.dp16,
      fontWeight: FontWeight.bold,
    ),
  );

  /// Input Decoration Theme
  static InputDecorationTheme inputDecoration = InputDecorationTheme(
    border: OutlineInputBorder(
      // borderSide: BorderSide(color: AppColors.blueColor),
      borderRadius: BorderRadius.circular(Dimens.dp4),
    ),
    enabledBorder: OutlineInputBorder(
      // borderSide: BorderSide(color: AppColors.blueColor),
      borderRadius: BorderRadius.circular(Dimens.dp8),
    ),
    focusedBorder: OutlineInputBorder(
      // borderSide: BorderSide(color: AppColors.blueColor),
      borderRadius: BorderRadius.circular(Dimens.dp8),
    ),
    errorBorder: OutlineInputBorder(
      // borderSide: BorderSide(color: AppColors.redColor, width: 1),
      borderRadius: BorderRadius.circular(Dimens.dp8),
    ),
  );
}
