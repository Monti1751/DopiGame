import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String _themeKey = 'theme_mode';
  static const String _fontKey = 'font_size';
  static const String _localeKey = 'locale';

  SettingsBloc() : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ChangeThemeEvent>(_onChangeTheme);
    on<ChangeFontSizeEvent>(_onChangeFontSize);
    on<ChangeLocaleEvent>(_onChangeLocale);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    
    final themeIndex = prefs.getInt(_themeKey) ?? AppThemeMode.light.index;
    final fontSize = prefs.getDouble(_fontKey) ?? 1.0;
    final locale = prefs.getString(_localeKey) ?? 'es';

    emit(SettingsState(
      themeMode: AppThemeMode.values[themeIndex],
      fontSizeMultiplier: fontSize,
      locale: locale,
    ));
  }

  Future<void> _onChangeTheme(ChangeThemeEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(themeMode: event.themeMode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, event.themeMode.index);
  }

  Future<void> _onChangeFontSize(ChangeFontSizeEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(fontSizeMultiplier: event.multiplier));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontKey, event.multiplier);
  }

  Future<void> _onChangeLocale(ChangeLocaleEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(locale: event.locale));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, event.locale);
  }
}
