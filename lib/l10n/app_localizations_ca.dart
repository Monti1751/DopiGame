// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'DopiGame';

  @override
  String get welcomeMessage => 'Hola, aventurer! Què farem avui?';

  @override
  String get taskCompleted => 'Tasca completada!';

  @override
  String xpGained(int xp) {
    return 'Has guanyat $xp punts d\'experiència';
  }

  @override
  String levelUp(int level) {
    return 'Has pujat al nivell $level!';
  }

  @override
  String get categoryMedical => 'Cita Mèdica';

  @override
  String get categoryHabit => 'Hàbit Diari';

  @override
  String get categoryEvent => 'Esdeveniment Especial';

  @override
  String get noTasks =>
      'Tot està tranquil per aquí... Pren un te o afegeix una tasca.';

  @override
  String statsLevel(Object level) {
    return 'Nivell $level';
  }

  @override
  String get statsProgress => 'Progrés de nivell';

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
  String get sanctuaryTitle => 'Santuari';

  @override
  String get sanctuaryEmpty => 'El teu santuari està a punt però buit!';

  @override
  String get sanctuaryBuyFirstBackground => 'Comprar el meu primer fons';

  @override
  String get sanctuaryNoBackground =>
      'Compra un fons a la botiga per començar.';

  @override
  String get sanctuaryInventoryTitle => 'El Teu Inventari';

  @override
  String get shopTitle => 'Botiga del Santuari';

  @override
  String get shopBuy => 'Comprar';

  @override
  String get shopBought => 'Comprat';

  @override
  String shopItemLevel(int level) {
    return 'Nivell $level';
  }

  @override
  String get shopPurchaseSuccess => 'Ítem comprat!';

  @override
  String get itemForestName => 'Bosc Somnolent';

  @override
  String get itemZenGardenName => 'Jardí Zen';

  @override
  String get itemJapaneseGardenName => 'Jardí Japonés';

  @override
  String get itemCrystalCaveName => 'Cova de Cristall';

  @override
  String get itemStarryNightName => 'Nit Estrellada';

  @override
  String get itemAutumnEveningName => 'Tarda de Tardor';

  @override
  String get itemCushionName => 'Coixí Còmode';

  @override
  String get itemTeaTableName => 'Taula de Te';

  @override
  String get itemPaperLampName => 'Làmpada de Paper';

  @override
  String get itemSakuraTreeName => 'Arbre de Sakura';

  @override
  String get itemPillowXLName => 'Coixí XL';

  @override
  String get itemStoneLampName => 'Fanalet de Pedra';

  @override
  String get itemBonsaiName => 'Bonsai Mil·lenari';
}
