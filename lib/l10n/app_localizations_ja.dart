// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'DopiGame';

  @override
  String get welcomeMessage => 'こんにちは、冒険者！今日は何をしましょうか？';

  @override
  String get taskCompleted => 'タスク完了！';

  @override
  String xpGained(int xp) {
    return '$xp経験値を獲得しました';
  }

  @override
  String levelUp(int level) {
    return 'レベル$levelに上がりました！';
  }

  @override
  String get categoryMedical => '医療予約';

  @override
  String get categoryHabit => '毎日の習慣';

  @override
  String get categoryEvent => '特別なイベント';

  @override
  String get noTasks => 'ここは静かですね……お茶を飲むか、タスクを追加してください。';

  @override
  String statsLevel(Object level) {
    return 'レベル $level';
  }

  @override
  String get statsProgress => 'レベル進行度';

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
}
