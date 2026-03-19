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
import 'features/sanctuary/data/repositories/sanctuary_repository_impl.dart';
import 'features/sanctuary/domain/usecases/get_unlocked_items_usecase.dart';
import 'features/sanctuary/domain/usecases/purchase_item_usecase.dart';
import 'features/sanctuary/domain/usecases/toggle_item_placement_usecase.dart';
import 'features/sanctuary/presentation/bloc/sanctuary_bloc.dart';
import 'features/sanctuary/presentation/bloc/shop_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set immersive mode (hide navigation and status bars)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  try {
    // Initialize Notification Service
    await NotificationService().init();

    // Initialize Database Helper
    final dbHelper = DatabaseHelper.instance;
    print("Main: Awaiting database initialization...");
    final db = await dbHelper.database; 
    print("Main: Database initialized. Path: ${db.path}");
    
    // Safety check for user_stats on first launch
    final stats = await db.query('user_stats', where: 'id = 1');
    if (stats.isEmpty) {
       print("Main: User stats not found! Attempting re-initialization...");
       // This shouldn't happen if onCreate/onUpgrade are correct, but let's be safe
       // We could trigger a force-insert here if needed
    }

    // Setting up DI dependencies
    final gamificationRepository = GamificationRepositoryImpl(dbHelper);
    final completeTaskUseCase = CompleteTaskUseCase(gamificationRepository);

    final sanctuaryRepository = SanctuaryRepositoryImpl(dbHelper);
    final getUnlockedItemsUseCase = GetUnlockedItemsUseCase(sanctuaryRepository);
    final purchaseItemUseCase = PurchaseItemUseCase(sanctuaryRepository, gamificationRepository);
    final toggleItemPlacementUseCase = ToggleItemPlacementUseCase(sanctuaryRepository);

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
          BlocProvider(
            create: (context) => SanctuaryBloc(
              repository: sanctuaryRepository,
              toggleItemPlacementUseCase: toggleItemPlacementUseCase,
            ),
          ),
          BlocProvider(
            create: (context) => ShopBloc(
              getUnlockedItemsUseCase: getUnlockedItemsUseCase,
              purchaseItemUseCase: purchaseItemUseCase,
              sanctuaryRepository: sanctuaryRepository,
            ),
          ),
        ],
        child: const CozyQuestApp(),
      ),
    );
  } catch (e, stack) {
    print("FATAL STARTUP ERROR: $e");
    print(stack);
    runApp(MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              const Text("Ocurrió un error al iniciar:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(e.toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.redAccent)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => main(), 
                child: const Text("Reintentar"),
              ),
            ],
          ),
        ),
      ),
    ));
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
