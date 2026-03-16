import 'package:equatable/equatable.dart';

enum AppThemeMode { light, dark, colorblind }

class SettingsState extends Equatable {
  final AppThemeMode themeMode;
  final double fontSizeMultiplier;
  final String locale; // e.g. 'es', 'en'

  const SettingsState({
    this.themeMode = AppThemeMode.light,
    this.fontSizeMultiplier = 1.0,
    this.locale = 'es', // Default to Spanish as requested originally
  });

  SettingsState copyWith({
    AppThemeMode? themeMode,
    double? fontSizeMultiplier,
    String? locale,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      fontSizeMultiplier: fontSizeMultiplier ?? this.fontSizeMultiplier,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, fontSizeMultiplier, locale];
}
