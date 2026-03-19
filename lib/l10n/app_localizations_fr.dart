// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'DopiGame';

  @override
  String get welcomeMessage =>
      'Bonjour, aventurier ! Que ferons-nous aujourd\'hui ?';

  @override
  String get taskCompleted => 'Tâche terminée !';

  @override
  String xpGained(int xp) {
    return 'Vous avez gagné $xp points d\'expérience';
  }

  @override
  String levelUp(int level) {
    return 'Vous êtes passé au niveau $level !';
  }

  @override
  String get categoryMedical => 'Rendez-vous médical';

  @override
  String get categoryHabit => 'Habitude quotidienne';

  @override
  String get categoryEvent => 'Événement spécial';

  @override
  String get noTasks =>
      'C\'est calme par ici... Prenez un thé ou ajoutez une tâche.';

  @override
  String statsLevel(Object level) {
    return 'Niveau $level';
  }

  @override
  String get statsProgress => 'Progression du niveau';

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
  String get sanctuaryTitle => 'Sanctuaire';

  @override
  String get sanctuaryEmpty => 'Votre sanctuaire est prêt mais vide !';

  @override
  String get sanctuaryBuyFirstBackground => 'Acheter mon premier fond';

  @override
  String get sanctuaryNoBackground =>
      'Achetez un fond dans la boutique pour commencer.';

  @override
  String get sanctuaryInventoryTitle => 'Votre Inventaire';

  @override
  String get shopTitle => 'Boutique du Sanctuaire';

  @override
  String get shopBuy => 'Acheter';

  @override
  String get shopBought => 'Acheté';

  @override
  String shopItemLevel(int level) {
    return 'Niveau $level';
  }

  @override
  String get shopPurchaseSuccess => 'Article acheté !';

  @override
  String get itemForestName => 'Forêt Endormie';

  @override
  String get itemZenGardenName => 'Jardin Zen';

  @override
  String get itemJapaneseGardenName => 'Jardins Japonais';

  @override
  String get itemCrystalCaveName => 'Grotte de Cristal';

  @override
  String get itemStarryNightName => 'Nuit Étoilée';

  @override
  String get itemAutumnEveningName => 'Soirée d\'Automne';

  @override
  String get itemCushionName => 'Coussin Confortable';

  @override
  String get itemTeaTableName => 'Table de Thé';

  @override
  String get itemPaperLampName => 'Lampe en Papier';

  @override
  String get itemSakuraTreeName => 'Cerisier Sakura';

  @override
  String get itemPillowXLName => 'Oreiller XL';

  @override
  String get itemStoneLampName => 'Lanterne en Pierre';

  @override
  String get itemBonsaiName => 'Bonsaï Millénaire';
}
