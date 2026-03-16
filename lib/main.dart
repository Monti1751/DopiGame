import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:dopi_game/l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/database/database_helper.dart';
import 'core/settings/bloc/settings_bloc.dart';
import 'core/settings/bloc/settings_event.dart';
import 'core/settings/bloc/settings_state.dart';
import 'core/services/notification_service.dart';

import 'features/gamification/data/repositories/gamification_repository_impl.dart';
import 'features/gamification/domain/usecases/complete_task_usecase.dart';
import 'features/gamification/presentation/bloc/gamification_bloc.dart';
import 'features/gamification/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set immersive mode (hide navigation and status bars)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  try {
    // Initialize Notification Service
    await NotificationService().init();

    // Initialize Database Helper
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.database; // Ensure the DB is created

    // Setting up DI dependencies
    final gamificationRepository = GamificationRepositoryImpl(dbHelper);
    final completeTaskUseCase = CompleteTaskUseCase(gamificationRepository);

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsBloc()..add(LoadSettings()),
          ),
          BlocProvider(
            create: (context) => GamificationBloc(
              repository: gamificationRepository,
              completeTaskUseCase: completeTaskUseCase,
            ),
          ),
        ],
        child: const CozyQuestApp(),
      ),
    );
  } catch (e) {
    print("FATAL STARTUP ERROR: $e");
    // Even if initialization fails, try to show the app shell
    // The BLoCs might fail later but it's better than a black screen
    runApp(const MaterialApp(home: Scaffold(body: Center(child: Text("Ocurrió un error al iniciar. Por favor reinicia la app.")))));
  }
}

class CozyQuestApp extends StatelessWidget {
  const CozyQuestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        ThemeData themeData;
        switch (state.themeMode) {
          case AppThemeMode.dark:
            themeData = AppTheme.darkTheme;
            break;
          case AppThemeMode.colorblind:
            themeData = AppTheme.colorBlindTheme;
            break;
          case AppThemeMode.light:
          default:
            themeData = AppTheme.cozyTheme;
            break;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DopiGame',
          theme: themeData,
          locale: Locale(state.locale),
          builder: (context, child) {
            // Apply global font size multiplier
            final data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                textScaler: TextScaler.linear(state.fontSizeMultiplier),
              ),
              child: child!,
            );
          },
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
            Locale('ca', ''),
            Locale('fr', ''),
            Locale('pt', ''),
            Locale('de', ''),
            Locale('it', ''),
            Locale('zh', ''),
            Locale('ja', ''),
            Locale('ar', ''),
            Locale('uk', ''),
            Locale('bg', ''),
          ],
          home: const HomePage(),
        );
      },
    );
  }
}
