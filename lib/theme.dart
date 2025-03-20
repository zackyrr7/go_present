import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.blue[50],
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.white,
      surface: Colors.blue[50]!, // Warna container saat light mode
      onSurface: Colors.black, // Warna teks di atas surface
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: Colors.blue[50]!),
      bodyMedium: const TextStyle(color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.blue[50], // Warna background TextField saat terang
      labelStyle:
          const TextStyle(color: Colors.black), // Warna label saat terang
      hintStyle:
          const TextStyle(color: Colors.black45), // Warna hint saat terang
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.black38,
      secondary: Colors.grey[850]!,
      surface: Colors.white24, // Warna container saat dark mode
      onSurface: Colors.white, // Warna teks di atas surface
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: Colors.blue[50]!),
      bodyMedium: const TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800], // Warna background TextField saat gelap
      labelStyle:
          const TextStyle(color: Colors.white), // Warna label saat gelap
      hintStyle:
          const TextStyle(color: Colors.white70), // Warna hint saat gelap
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
