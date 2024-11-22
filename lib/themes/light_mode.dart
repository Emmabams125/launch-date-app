import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.red.shade500, // Primary pink color
    secondary: Colors.red.shade200, // Secondary pink color
    background: Colors.grey.shade300, // Background color
    inversePrimary: Colors.red.shade900, // Darker pink for contrast
  ),
);
