import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bg.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bg'),
    Locale('ca'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('uk'),
    Locale('zh')
  ];

  /// El nombre de la aplicación
  ///
  /// In es, this message translates to:
  /// **'DopiGame'**
  String get appTitle;

  /// No description provided for @welcomeMessage.
  ///
  /// In es, this message translates to:
  /// **'¡Hola, aventurero! ¿Qué haremos hoy?'**
  String get welcomeMessage;

  /// No description provided for @taskCompleted.
  ///
  /// In es, this message translates to:
  /// **'¡Tarea completada!'**
  String get taskCompleted;

  /// No description provided for @xpGained.
  ///
  /// In es, this message translates to:
  /// **'Has ganado {xp} puntos de experiencia'**
  String xpGained(int xp);

  /// No description provided for @levelUp.
  ///
  /// In es, this message translates to:
  /// **'¡Subiste al nivel {level}!'**
  String levelUp(int level);

  /// No description provided for @categoryMedical.
  ///
  /// In es, this message translates to:
  /// **'Cita Médica'**
  String get categoryMedical;

  /// No description provided for @categoryHabit.
  ///
  /// In es, this message translates to:
  /// **'Hábito Diario'**
  String get categoryHabit;

  /// No description provided for @categoryEvent.
  ///
  /// In es, this message translates to:
  /// **'Evento Especial'**
  String get categoryEvent;

  /// No description provided for @noTasks.
  ///
  /// In es, this message translates to:
  /// **'Todo está tranquilo por aquí... Tómate un té o añade una tarea.'**
  String get noTasks;

  /// No description provided for @statsLevel.
  ///
  /// In es, this message translates to:
  /// **'Nivel {level}'**
  String statsLevel(Object level);

  /// No description provided for @statsProgress.
  ///
  /// In es, this message translates to:
  /// **'Progreso de nivel'**
  String get statsProgress;

  /// No description provided for @addTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'Añadir Nueva Tarea'**
  String get addTaskTitle;

  /// No description provided for @taskNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la Tarea'**
  String get taskNameLabel;

  /// No description provided for @taskNameHint.
  ///
  /// In es, this message translates to:
  /// **'Ej., Leer 10 páginas'**
  String get taskNameHint;

  /// No description provided for @taskDescriptionLabel.
  ///
  /// In es, this message translates to:
  /// **'Descripción (Opcional)'**
  String get taskDescriptionLabel;

  /// No description provided for @taskDescriptionHint.
  ///
  /// In es, this message translates to:
  /// **'Añade más detalles aquí...'**
  String get taskDescriptionHint;

  /// No description provided for @categoryLabel.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get categoryLabel;

  /// No description provided for @dueDateLabel.
  ///
  /// In es, this message translates to:
  /// **'Fecha Límite'**
  String get dueDateLabel;

  /// No description provided for @priorityLabel.
  ///
  /// In es, this message translates to:
  /// **'Prioridad'**
  String get priorityLabel;

  /// No description provided for @priorityNormal.
  ///
  /// In es, this message translates to:
  /// **'Normal (1x XP)'**
  String get priorityNormal;

  /// No description provided for @priorityHigh.
  ///
  /// In es, this message translates to:
  /// **'Alta (1.5x XP)'**
  String get priorityHigh;

  /// No description provided for @saveTaskButton.
  ///
  /// In es, this message translates to:
  /// **'Guardar Tarea'**
  String get saveTaskButton;

  /// No description provided for @errorRequiredField.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get errorRequiredField;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settingsTitle;

  /// No description provided for @themeSection.
  ///
  /// In es, this message translates to:
  /// **'Tema Visual'**
  String get themeSection;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @themeColorblind.
  ///
  /// In es, this message translates to:
  /// **'Daltónico'**
  String get themeColorblind;

  /// No description provided for @fontSizeSection.
  ///
  /// In es, this message translates to:
  /// **'Tamaño de Letra'**
  String get fontSizeSection;

  /// No description provided for @languageSection.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get languageSection;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// No description provided for @changeAvatar.
  ///
  /// In es, this message translates to:
  /// **'Cambiar Foto'**
  String get changeAvatar;

  /// No description provided for @camera.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In es, this message translates to:
  /// **'Galería'**
  String get gallery;

  /// No description provided for @totalCompletedTasks.
  ///
  /// In es, this message translates to:
  /// **'Tareas Completadas'**
  String get totalCompletedTasks;

  /// No description provided for @totalXp.
  ///
  /// In es, this message translates to:
  /// **'XP Total'**
  String get totalXp;

  /// No description provided for @permissionDenied.
  ///
  /// In es, this message translates to:
  /// **'Permiso denegado. Por favor, habilítalo en los ajustes.'**
  String get permissionDenied;

  /// No description provided for @taskDetailsTitle.
  ///
  /// In es, this message translates to:
  /// **'Detalles de la Tarea'**
  String get taskDetailsTitle;

  /// No description provided for @editTask.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get editTask;

  /// No description provided for @deleteTask.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get deleteTask;

  /// No description provided for @deleteConfirmationTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar Tarea?'**
  String get deleteConfirmationTitle;

  /// No description provided for @deleteConfirmationBody.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas eliminar esta tarea?'**
  String get deleteConfirmationBody;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// No description provided for @editTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar Tarea'**
  String get editTaskTitle;

  /// No description provided for @updateTaskButton.
  ///
  /// In es, this message translates to:
  /// **'Actualizar Tarea'**
  String get updateTaskButton;

  /// No description provided for @categoryTask.
  ///
  /// In es, this message translates to:
  /// **'Tarea'**
  String get categoryTask;

  /// No description provided for @taskCreatedToast.
  ///
  /// In es, this message translates to:
  /// **'¡Tarea creada con éxito!'**
  String get taskCreatedToast;

  /// No description provided for @taskUpdatedToast.
  ///
  /// In es, this message translates to:
  /// **'¡Tarea actualizada!'**
  String get taskUpdatedToast;

  /// No description provided for @taskDeletedToast.
  ///
  /// In es, this message translates to:
  /// **'¡Tarea eliminada!'**
  String get taskDeletedToast;

  /// No description provided for @usernameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre de Usuario'**
  String get usernameLabel;

  /// No description provided for @editName.
  ///
  /// In es, this message translates to:
  /// **'Editar Nombre'**
  String get editName;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @sanctuaryTitle.
  ///
  /// In es, this message translates to:
  /// **'Santuario'**
  String get sanctuaryTitle;

  /// No description provided for @sanctuaryEmpty.
  ///
  /// In es, this message translates to:
  /// **'¡Tu santuario está listo pero vacío!'**
  String get sanctuaryEmpty;

  /// No description provided for @sanctuaryBuyFirstBackground.
  ///
  /// In es, this message translates to:
  /// **'Comprar mi primer fondo'**
  String get sanctuaryBuyFirstBackground;

  /// No description provided for @sanctuaryNoBackground.
  ///
  /// In es, this message translates to:
  /// **'Compra un fondo en la tienda para empezar.'**
  String get sanctuaryNoBackground;

  /// No description provided for @sanctuaryInventoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu Inventario'**
  String get sanctuaryInventoryTitle;

  /// No description provided for @shopTitle.
  ///
  /// In es, this message translates to:
  /// **'Tienda del Santuario'**
  String get shopTitle;

  /// No description provided for @shopBuy.
  ///
  /// In es, this message translates to:
  /// **'Comprar'**
  String get shopBuy;

  /// No description provided for @shopBought.
  ///
  /// In es, this message translates to:
  /// **'Comprado'**
  String get shopBought;

  /// No description provided for @shopItemLevel.
  ///
  /// In es, this message translates to:
  /// **'Nivel {level}'**
  String shopItemLevel(int level);

  /// No description provided for @shopPurchaseSuccess.
  ///
  /// In es, this message translates to:
  /// **'¡Item comprado!'**
  String get shopPurchaseSuccess;

  /// No description provided for @itemForestName.
  ///
  /// In es, this message translates to:
  /// **'Bosque Somnoliento'**
  String get itemForestName;

  /// No description provided for @itemZenGardenName.
  ///
  /// In es, this message translates to:
  /// **'Jardín Zen'**
  String get itemZenGardenName;

  /// No description provided for @itemJapaneseGardenName.
  ///
  /// In es, this message translates to:
  /// **'Jardín Japonés'**
  String get itemJapaneseGardenName;

  /// No description provided for @itemCrystalCaveName.
  ///
  /// In es, this message translates to:
  /// **'Cueva de Cristal'**
  String get itemCrystalCaveName;

  /// No description provided for @itemStarryNightName.
  ///
  /// In es, this message translates to:
  /// **'Noche Estrellada'**
  String get itemStarryNightName;

  /// No description provided for @itemAutumnEveningName.
  ///
  /// In es, this message translates to:
  /// **'Tarde de Otoño'**
  String get itemAutumnEveningName;

  /// No description provided for @itemCushionName.
  ///
  /// In es, this message translates to:
  /// **'Cojín Cómodo'**
  String get itemCushionName;

  /// No description provided for @itemTeaTableName.
  ///
  /// In es, this message translates to:
  /// **'Mesa de Té'**
  String get itemTeaTableName;

  /// No description provided for @itemPaperLampName.
  ///
  /// In es, this message translates to:
  /// **'Lámpara de Papel'**
  String get itemPaperLampName;

  /// No description provided for @itemSakuraTreeName.
  ///
  /// In es, this message translates to:
  /// **'Árbol de Sakura'**
  String get itemSakuraTreeName;

  /// No description provided for @itemPillowXLName.
  ///
  /// In es, this message translates to:
  /// **'Almohada XL'**
  String get itemPillowXLName;

  /// No description provided for @itemStoneLampName.
  ///
  /// In es, this message translates to:
  /// **'Farol de Piedra'**
  String get itemStoneLampName;

  /// No description provided for @itemBonsaiName.
  ///
  /// In es, this message translates to:
  /// **'Bonsai Milenario'**
  String get itemBonsaiName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'bg',
        'ca',
        'de',
        'en',
        'es',
        'fr',
        'it',
        'ja',
        'pt',
        'uk',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bg':
      return AppLocalizationsBg();
    case 'ca':
      return AppLocalizationsCa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
