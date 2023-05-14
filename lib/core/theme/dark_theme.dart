import 'package:flutter/material.dart';

/**
 * Date: 5 Nov 2022
 * Title: DarkTheme class
 * Description: This class will hold theme data
 * Developer: Md. Rasel Khan
 * Position: Sr. Mobile Application Developer
 * Start Date: Today
 * End Date: Today
 */

class DarkTheme {
  static var dark = ThemeData.dark().copyWith(
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        height: 45,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: color.primary,
          elevation: 0,
          titleTextStyle: TextStyle(color: color.primary)),
      bottomAppBarTheme: BottomAppBarTheme(
        color: color.primary,
        elevation: 0,
      ),
      backgroundColor: color.onSecondary,
      brightness: Brightness.light,
      colorScheme: color);

  /// - @ [ColorScheme] return some color type.
  /// - @ [primary] - [secondary] - [onPrimary] - [onSecondary]
  /// - @ [surface] - [error]
  static ColorScheme color = ColorScheme.light(
    primary: Color(0xff38B89A),
    onPrimary: Colors.white,
    secondary: Color(0xffCAFEF2),
    onSecondary: Color(0xff38B89A),
    brightness: Brightness.light,
    background: Color(0xffEDFFF9),
    onBackground: Colors.white,
    error: Colors.red.shade400,
    onError: Colors.red.shade50,
    surface: Color(0xff38B89A),
    onSurface: Colors.white,
    errorContainer: Colors.red.shade400,
    onErrorContainer: Colors.red.shade50,
    outline: Color(0xff38B89A).withOpacity(.5),
    shadow: Color(0xff38B89A).withOpacity(.3),
  );
}
