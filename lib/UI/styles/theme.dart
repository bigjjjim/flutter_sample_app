import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  //define color scheme
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: customLightBlue,
    secondary: Colors.green,
  ),

  // define text theme
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: customLightBlue,
    ),
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: customLightBlue,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: customLightBlue,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16.0,
      color: Colors.black87,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14.0,
      color: Colors.black87,
    ),
    bodySmall: const TextStyle(
      fontSize: 12.0,
      color: Colors.black54,
    ),
  ),

  // Input Decoration (for TextFormFields, etc.)
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: customLightBlue,
        width: 2.0,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 2.0,
      ),
    ),
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
  ),
);

//colors
Color customLightBlue = const Color(0xff9DD9F3);
