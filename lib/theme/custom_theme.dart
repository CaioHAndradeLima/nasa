
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {

  static TextTheme _defaultTextTheme(BuildContext context) {
    return TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleSmall: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: Colors.black,
      ),
    );
  }

  static ThemeData defaultTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(color: Colors.green, shadowColor: Colors.red,
          elevation: 1, foregroundColor: Colors.white),
      textTheme: _defaultTextTheme(context),
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData(
        useMaterial3: true
    );
  }
}