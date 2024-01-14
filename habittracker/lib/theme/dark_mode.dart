import 'package:flutter/material.dart';

class DarkMode {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        background: Colors.grey.shade900,
        primary: Colors.grey.shade600,
        secondary: Colors.grey.shade700,
        tertiary: Colors.grey.shade800,
        surface: Colors.grey.shade800,
        onBackground: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
    );
  }
}
