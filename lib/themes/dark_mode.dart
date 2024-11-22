import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.red.shade500, // Primary pink color
    secondary: Colors.red.shade200, // Secondary pink color
    background: Colors.grey[900], // Dark background
    inversePrimary: Colors.red.shade900, // Darker pink for contrast
  ),
);
