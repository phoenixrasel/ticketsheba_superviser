import 'package:flutter/material.dart';

import '../extra/app_dimens.dart';
import 'extra_colors.dart';

/**
 * Date: 5 Nov 2022
 * Title: LightTheme class
 * Description: This class will hold light theme data
 * Developer: Md. Rasel Khan
 * Position: Sr. Mobile Application Developer
 * Start Date: Today
 * End Date: Today
 */
class LightTheme {
  static var light = ThemeData.light().copyWith(
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        height: 45,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: color.primary,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: color.onPrimary,
              fontSize: AppDimens.tSmall,
              // fontSize: AppDimens.tH3,
              fontWeight: FontWeight.normal)),
      bottomAppBarTheme: BottomAppBarTheme(
        color: color.primary,
        elevation: 0,
      ),
      primaryColor: color.primary,
      scaffoldBackgroundColor: color.onPrimary,
      brightness: Brightness.light,
      colorScheme: color,
      hintColor: Colors.grey.shade400);

  /// - @ [ColorScheme] return some color type.
  /// - @ [primary] - [secondary] - [onPrimary] - [onSecondary]
  /// - @ [surface] - [error]
  static ColorScheme color = ColorScheme.light(
    ///------------------------------------------- primary
    primaryContainer: Color.fromARGB(255, 129, 11, 23),
    primary: Color(0xffdc3545),
    onPrimary: Color(0xffF9F9F9),
    inversePrimary: Color(0xffF58B00),

    ///------------------------------------------- secondary
    secondaryContainer: Color(0xff063175),
    secondary: Color.fromARGB(255, 129, 11, 23),
    onSecondary: Color(0xffF9F9F9),
    onSecondaryContainer: Color(0xff24A8F4),

    ///------------------------------------------- others
    brightness: Brightness.light,
    background: Color(0xffF9B03E),
    onBackground: Color(0xffF9F9F9),
    error: Colors.red.shade400,
    onError: Colors.red.shade50,
    surface: Colors.black,

    onSurface: Colors.white,
    errorContainer: Colors.red.shade400,
    onErrorContainer: Colors.red.shade50,
    outline: Color(0xff38B89A).withOpacity(.5),
    shadow: Color(0xff38B89A).withOpacity(.3),
  );
}
