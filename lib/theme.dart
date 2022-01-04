import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookishTheme {
  static TextTheme lightTextTheme = TextTheme(
      headline1: GoogleFonts.sourceSerifPro(
        fontSize: 48.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headline2: GoogleFonts.sourceSerifPro(
        fontSize: 40.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headline3: GoogleFonts.sourceSerifPro(
        fontSize: 32.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headline4: GoogleFonts.sourceSerifPro(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headline5: GoogleFonts.sourceSerifPro(
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headline6: GoogleFonts.sourceSerifPro(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodyText1: GoogleFonts.sourceSerifPro(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodyText2: GoogleFonts.sourceSerifPro(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ));

  static TextTheme darkTextTheme = TextTheme(
      headline1: GoogleFonts.sourceSerifPro(
        fontSize: 48.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline2: GoogleFonts.sourceSerifPro(
        fontSize: 40.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline3: GoogleFonts.sourceSerifPro(
        fontSize: 32.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline4: GoogleFonts.sourceSerifPro(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline5: GoogleFonts.sourceSerifPro(
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headline6: GoogleFonts.sourceSerifPro(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyText1: GoogleFonts.sourceSerifPro(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyText2: GoogleFonts.sourceSerifPro(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ));

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
          primary: Color(0xfff9a826),
          primaryVariant: Color(0xfff9a826),
          secondary: Colors.black,
          secondaryVariant: Colors.black),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.black,
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
          primary: Color(0xfff9a826),
          primaryVariant: Color(0xfff9a826),
          secondary: Colors.white,
          secondaryVariant: Colors.white),
      appBarTheme: AppBarTheme(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
      ),
      textTheme: darkTextTheme,
    );
  }
}
