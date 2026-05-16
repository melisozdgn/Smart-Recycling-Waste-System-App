import 'package:flutter/material.dart';
import 'colors.dart';

class SrwsTheme {
  SrwsTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: SrwsColors.primary,
      scaffoldBackgroundColor: SrwsColors.background,
      colorScheme: const ColorScheme.light(
        primary: SrwsColors.primary,
        secondary: SrwsColors.secondary,
        surface: SrwsColors.surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: SrwsColors.primary,
        foregroundColor: SrwsColors.surface,
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: SrwsColors.surface,
        selectedItemColor: SrwsColors.primary,
        unselectedItemColor: SrwsColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}