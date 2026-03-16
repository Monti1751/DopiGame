import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dopi_game/l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/settings/bloc/settings_bloc.dart';
import '../../../../core/settings/bloc/settings_event.dart';
import '../../../../core/settings/bloc/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.settingsTitle, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            children: [
              _buildSectionTitle(theme, l10n.themeSection),
              _buildThemeSelector(context, state, l10n),
              const SizedBox(height: AppConstants.paddingLarge),

              _buildSectionTitle(theme, l10n.fontSizeSection),
              _buildFontSizeSlider(context, state),
              const SizedBox(height: AppConstants.paddingLarge),

              _buildSectionTitle(theme, l10n.languageSection),
              _buildLanguageSelector(context, state, l10n),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context, SettingsState state, AppLocalizations l10n) {
    return Card(
      child: Column(
        children: [
          RadioListTile<AppThemeMode>(
            title: Text(l10n.themeLight),
            value: AppThemeMode.light,
            groupValue: state.themeMode,
            onChanged: (value) {
              if (value != null) context.read<SettingsBloc>().add(ChangeThemeEvent(value));
            },
          ),
          RadioListTile<AppThemeMode>(
            title: Text(l10n.themeDark),
            value: AppThemeMode.dark,
            groupValue: state.themeMode,
            onChanged: (value) {
              if (value != null) context.read<SettingsBloc>().add(ChangeThemeEvent(value));
            },
          ),
          RadioListTile<AppThemeMode>(
            title: Text(l10n.themeColorblind),
            value: AppThemeMode.colorblind,
            groupValue: state.themeMode,
            onChanged: (value) {
              if (value != null) context.read<SettingsBloc>().add(ChangeThemeEvent(value));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeSlider(BuildContext context, SettingsState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium, vertical: AppConstants.paddingLarge),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('A', style: TextStyle(fontSize: 14)),
                Text('${(state.fontSizeMultiplier * 100).toInt()}%', style: Theme.of(context).textTheme.titleMedium),
                const Text('A', style: TextStyle(fontSize: 24)),
              ],
            ),
            Slider(
              value: state.fontSizeMultiplier,
              min: 0.8,
              max: 1.5,
              divisions: 7,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                context.read<SettingsBloc>().add(ChangeFontSizeEvent(value));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context, SettingsState state, AppLocalizations l10n) {
    final Map<String, String> languages = {
      'es': 'Español',
      'en': 'English',
      'fr': 'Français',
      'de': 'Deutsch',
      'it': 'Italiano',
      'pt': 'Português',
      'ca': 'Català',
      'bg': 'Български',
      'uk': 'Українська',
      'zh': '中文',
      'ja': '日本語',
      'ar': 'العربية',
    };

    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          String langCode = languages.keys.elementAt(index);
          String langName = languages.values.elementAt(index);
          return RadioListTile<String>(
            title: Text(langName),
            value: langCode,
            groupValue: state.locale,
            onChanged: (value) {
              if (value != null) context.read<SettingsBloc>().add(ChangeLocaleEvent(value));
            },
          );
        },
      ),
    );
  }
}
