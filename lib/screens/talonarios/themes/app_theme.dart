import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.blue;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: const Color.fromRGBO(90, 97, 195, 1),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: primaryColor, primary: Colors.white)));
}
