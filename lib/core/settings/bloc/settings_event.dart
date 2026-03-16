import 'package:equatable/equatable.dart';
import 'settings_state.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ChangeThemeEvent extends SettingsEvent {
  final AppThemeMode themeMode;
  const ChangeThemeEvent(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ChangeFontSizeEvent extends SettingsEvent {
  final double multiplier;
  const ChangeFontSizeEvent(this.multiplier);

  @override
  List<Object?> get props => [multiplier];
}

class ChangeLocaleEvent extends SettingsEvent {
  final String locale;
  const ChangeLocaleEvent(this.locale);

  @override
  List<Object?> get props => [locale];
}
