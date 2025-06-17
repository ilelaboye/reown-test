import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xFF2C57A6),
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.interTextTheme().copyWith(
      bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2C57A6),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xFF2C57A6),
    textTheme: GoogleFonts.interTextTheme().copyWith(
        bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        labelSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2C57A6),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    ),
  );
}
