import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeDataApp() {
  return ThemeData(
    primaryColor: Color(0xff38208C),
    focusColor: Color(0xffED553C),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff38208C),
        onPrimary: Colors.white,
        secondary: Color(0xffED553C),
        onSecondary: Colors.white,
        error: Color.fromARGB(255, 214, 80, 78),
        onError: Colors.white,
        background: Color(0xffFFEDED),
        onBackground: Color(0xffED553C),
        surface: Color(0xffE5D8F2),
        onSurface: Color(0xff38208C)),
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Color(0xffED553C)),
      color: Color(0xffF9F8FC),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
          color: Color(0xff38208C), fontWeight: FontWeight.w500, fontSize: 17),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Color(0xff38208C),
        textStyle: TextStyle(
          fontSize: 15
        ),
        padding: EdgeInsets.all(20)
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xffED553C)
    )
  );
}
