class AppConstants {
  // Gamificación
  static const int initialLevel = 1;
  static const int xpMultiplierEasy = 10;
  static const int xpMultiplierMedium = 20;
  static const int xpMultiplierHard = 50;

  // Diseño "Cozy" (Paleta de colores)
  static const int colorCream = 0xFFFFFDD0;
  static const int colorSage = 0xFFB2AC88;
  static const int colorTerracotta = 0xFFE2725B;
  static const int colorSoftBrown = 0xFF6D4C41;

  // Spacing & UI (Para evitar Magic Numbers en Padding/Radius)
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double borderRadiusCozy = 24.0;
  static const double elevationSoft = 2.0;

  // Database
  static const String dbName = 'cozy_quest.db';
  static const int dbVersion = 5;
}
