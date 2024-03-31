
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {

  static TextTheme _defaultTextTheme(BuildContext context) {
    return TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
      titleLarge: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleSmall: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.roboto(
        color: Colors.white,
      ),
    );
  }

  static ThemeData defaultTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        background: Colors.black,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(color: Colors.green),
      textTheme: _defaultTextTheme(context),
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData(
        useMaterial3: true
    );
  }
}