// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'DopiGame';

  @override
  String get welcomeMessage => 'Hallo Abenteurer! Was machen wir heute?';

  @override
  String get taskCompleted => 'Aufgabe abgeschlossen!';

  @override
  String xpGained(int xp) {
    return 'Du hast $xp Erfahrungspunkte gesammelt';
  }

  @override
  String levelUp(int level) {
    return 'Du bist auf Level $level aufgestiegen!';
  }

  @override
  String get categoryMedical => 'Arzttermin';

  @override
  String get categoryHabit => 'Tägliche Gewohnheit';

  @override
  String get categoryEvent => 'Besonderes Ereignis';

  @override
  String get noTasks =>
      'Hier ist es ruhig... Trink einen Tee oder füge eine Aufgabe hinzu.';

  @override
  String statsLevel(Object level) {
    return 'Level $level';
  }

  @override
  String get statsProgress => 'Level-Fortschritt';

  @override
  String get addTaskTitle => 'Añadir Nueva Tarea';

  @override
  String get taskNameLabel => 'Nombre de la Tarea';

  @override
  String get taskNameHint => 'Ej., Leer 10 páginas';

  @override
  String get taskDescriptionLabel => 'Descripción (Opcional)';

  @override
  String get taskDescriptionHint => 'Añade más detalles aquí...';

  @override
  String get categoryLabel => 'Categoría';

  @override
  String get dueDateLabel => 'Fecha Límite';

  @override
  String get priorityLabel => 'Prioridad';

  @override
  String get priorityNormal => 'Normal (1x XP)';

  @override
  String get priorityHigh => 'Alta (1.5x XP)';

  @override
  String get saveTaskButton => 'Guardar Tarea';

  @override
  String get errorRequiredField => 'Este campo es obligatorio';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get themeSection => 'Tema Visual';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeColorblind => 'Daltónico';

  @override
  String get fontSizeSection => 'Tamaño de Letra';

  @override
  String get languageSection => 'Idioma';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get changeAvatar => 'Cambiar Foto';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get totalCompletedTasks => 'Tareas Completadas';

  @override
  String get totalXp => 'XP Total';

  @override
  String get permissionDenied =>
      'Permiso denegado. Por favor, habilítalo en los ajustes.';

  @override
  String get taskDetailsTitle => 'Detalles de la Tarea';

  @override
  String get editTask => 'Editar';

  @override
  String get deleteTask => 'Eliminar';

  @override
  String get deleteConfirmationTitle => '¿Eliminar Tarea?';

  @override
  String get deleteConfirmationBody =>
      '¿Estás seguro de que deseas eliminar esta tarea?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get editTaskTitle => 'Editar Tarea';

  @override
  String get updateTaskButton => 'Actualizar Tarea';

  @override
  String get categoryTask => 'Tarea';

  @override
  String get taskCreatedToast => '¡Tarea creada con éxito!';

  @override
  String get taskUpdatedToast => '¡Tarea actualizada!';

  @override
  String get taskDeletedToast => '¡Tarea eliminada!';

  @override
  String get usernameLabel => 'Nombre de Usuario';

  @override
  String get editName => 'Editar Nombre';

  @override
  String get save => 'Guardar';

  @override
  String get sanctuaryTitle => 'Sanktuarium';

  @override
  String get sanctuaryEmpty => 'Dein Sanktuarium ist bereit, aber leer!';

  @override
  String get sanctuaryBuyFirstBackground => 'Meinen ersten Hintergrund kaufen';

  @override
  String get sanctuaryNoBackground =>
      'Kaufe einen Hintergrund im Laden, um zu beginnen.';

  @override
  String get sanctuaryInventoryTitle => 'Dein Inventar';

  @override
  String get shopTitle => 'Sanktuariums-Laden';

  @override
  String get shopBuy => 'Kaufen';

  @override
  String get shopBought => 'Gekauft';

  @override
  String shopItemLevel(int level) {
    return 'Stufe $level';
  }

  @override
  String get shopPurchaseSuccess => 'Artikel gekauft!';

  @override
  String get itemForestName => 'Schlummerwald';

  @override
  String get itemZenGardenName => 'Zen-Garten';

  @override
  String get itemJapaneseGardenName => 'Japanischer Garten';

  @override
  String get itemCrystalCaveName => 'Kristallhöhle';

  @override
  String get itemStarryNightName => 'Sternennacht';

  @override
  String get itemAutumnEveningName => 'Herbstabend';

  @override
  String get itemCushionName => 'Gemütliches Kissen';

  @override
  String get itemTeaTableName => 'Teetisch';

  @override
  String get itemPaperLampName => 'Papierlampe';

  @override
  String get itemSakuraTreeName => 'Sakura-Baum';

  @override
  String get itemPillowXLName => 'XL-Kissen';

  @override
  String get itemStoneLampName => 'Steinlaterne';

  @override
  String get itemBonsaiName => 'Uralter Bonsai';
}
