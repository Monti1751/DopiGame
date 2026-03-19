// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'DopiGame';

  @override
  String get welcomeMessage => 'Ciao, avventuriero! Cosa facciamo oggi?';

  @override
  String get taskCompleted => 'Attività completata!';

  @override
  String xpGained(int xp) {
    return 'Hai guadagnato $xp punti esperienza';
  }

  @override
  String levelUp(int level) {
    return 'Sei salito al livello $level!';
  }

  @override
  String get categoryMedical => 'Appuntamento Medico';

  @override
  String get categoryHabit => 'Abitudine Quotidiana';

  @override
  String get categoryEvent => 'Evento Speciale';

  @override
  String get noTasks =>
      'È tutto tranquillo qui... Prenditi un tè o aggiungi un\'attività.';

  @override
  String statsLevel(Object level) {
    return 'Livello $level';
  }

  @override
  String get statsProgress => 'Progresso del livello';

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
  String get sanctuaryTitle => 'Santuario';

  @override
  String get sanctuaryEmpty => '¡Tu santuario está listo pero vacío!';

  @override
  String get sanctuaryBuyFirstBackground => 'Comprar mi primer fondo';

  @override
  String get sanctuaryNoBackground =>
      'Compra un fondo en la tienda para empezar.';

  @override
  String get sanctuaryInventoryTitle => 'Tu Inventario';

  @override
  String get shopTitle => 'Tienda del Santuario';

  @override
  String get shopBuy => 'Comprar';

  @override
  String get shopBought => 'Comprado';

  @override
  String shopItemLevel(int level) {
    return 'Nivel $level';
  }

  @override
  String get shopPurchaseSuccess => '¡Item comprado!';

  @override
  String get itemForestName => 'Bosque Somnoliento';

  @override
  String get itemZenGardenName => 'Jardín Zen';

  @override
  String get itemJapaneseGardenName => 'Jardín Japonés';

  @override
  String get itemCrystalCaveName => 'Cueva de Cristal';

  @override
  String get itemStarryNightName => 'Noche Estrellada';

  @override
  String get itemAutumnEveningName => 'Tarde de Otoño';

  @override
  String get itemCushionName => 'Cojín Cómodo';

  @override
  String get itemTeaTableName => 'Mesa de Té';

  @override
  String get itemPaperLampName => 'Lámpara de Papel';

  @override
  String get itemSakuraTreeName => 'Árbol de Sakura';

  @override
  String get itemPillowXLName => 'Almohada XL';

  @override
  String get itemStoneLampName => 'Farol de Piedra';

  @override
  String get itemBonsaiName => 'Bonsai Milenario';
}
