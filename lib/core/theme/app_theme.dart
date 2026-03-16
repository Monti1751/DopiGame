import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData get cozyTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppConstants.colorSage),
        surface: const Color(AppConstants.colorCream),
        primary: const Color(AppConstants.colorSage),
        secondary: const Color(AppConstants.colorTerracotta),
        onSurface: const Color(AppConstants.colorSoftBrown),
      ),
      
      // Tipografía redondeada y amigable
      textTheme: GoogleFonts.quicksandTextTheme().apply(
        bodyColor: const Color(AppConstants.colorSoftBrown),
        displayColor: const Color(AppConstants.colorSoftBrown),
      ),

      // Tarjetas con bordes súper redondeados
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: AppConstants.elevationSoft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: AppConstants.paddingSmall,
          horizontal: AppConstants.paddingMedium,
        ),
      ),

      // Botones con estilo suave
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(AppConstants.colorTerracotta),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy),
          ),
        ),
      ),

      // Inputs (campos de texto) acogedores
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(AppConstants.paddingMedium),
      ),
      
      // Barra de navegación inferior
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(AppConstants.colorCream),
        indicatorColor: const Color(AppConstants.colorSage).withOpacity(0.2),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppConstants.colorSage),
        brightness: Brightness.dark,
        surface: const Color(0xFF1E1E1E),
        primary: const Color(0xFFB2AC88),
        secondary: const Color(0xFFE2725B),
        onSurface: Colors.white70,
      ),
      textTheme: GoogleFonts.quicksandTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        color: const Color(0xFF2C2C2C),
        elevation: AppConstants.elevationSoft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy),
        ),
        margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall, horizontal: AppConstants.paddingMedium),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(AppConstants.colorTerracotta),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(AppConstants.paddingMedium),
      ),
    );
  }

  static ThemeData get colorBlindTheme {
    // A high contrast theme using color-blind friendly palettes (e.g. blue/orange)
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF005AB5), // Strong blue
        surface: const Color(0xFFF0F0F0),
        primary: const Color(0xFF005AB5),
        secondary: const Color(0xFFDC3220), // Strong red/orange
        onSurface: Colors.black87,
      ),
      textTheme: GoogleFonts.quicksandTextTheme().apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: AppConstants.elevationSoft * 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy),
          side: const BorderSide(color: Colors.black12, width: 2), // High contrast border
        ),
        margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall, horizontal: AppConstants.paddingMedium),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFDC3220),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy),
          borderSide: const BorderSide(color: Colors.black26, width: 2),
        ),
        contentPadding: const EdgeInsets.all(AppConstants.paddingMedium),
      ),
    );
  }
}
