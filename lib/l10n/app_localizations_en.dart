// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DopiGame';

  @override
  String get welcomeMessage => 'Hello, adventurer! What shall we do today?';

  @override
  String get taskCompleted => 'Task completed!';

  @override
  String xpGained(int xp) {
    return 'You have gained $xp experience points';
  }

  @override
  String levelUp(int level) {
    return 'You leveled up to level $level!';
  }

  @override
  String get categoryMedical => 'Medical Appointment';

  @override
  String get categoryHabit => 'Daily Habit';

  @override
  String get categoryEvent => 'Special Event';

  @override
  String get noTasks =>
      'It is quiet around here... Have some tea or add a task.';

  @override
  String statsLevel(Object level) {
    return 'Level $level';
  }

  @override
  String get statsProgress => 'Level Progress';

  @override
  String get addTaskTitle => 'Add New Task';

  @override
  String get taskNameLabel => 'Task Name';

  @override
  String get taskNameHint => 'e.g., Read 10 pages';

  @override
  String get taskDescriptionLabel => 'Description (Optional)';

  @override
  String get taskDescriptionHint => 'Add more details here...';

  @override
  String get categoryLabel => 'Category';

  @override
  String get dueDateLabel => 'Due Date';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get priorityNormal => 'Normal (1x XP)';

  @override
  String get priorityHigh => 'High (1.5x XP)';

  @override
  String get saveTaskButton => 'Save Task';

  @override
  String get errorRequiredField => 'This field is required';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeSection => 'Visual Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeColorblind => 'Colorblind';

  @override
  String get fontSizeSection => 'Font Size';

  @override
  String get languageSection => 'Language';

  @override
  String get profileTitle => 'Profile';

  @override
  String get changeAvatar => 'Change Photo';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get totalCompletedTasks => 'Completed Tasks';

  @override
  String get totalXp => 'Total XP';

  @override
  String get permissionDenied =>
      'Permission denied. Please enable it in settings.';

  @override
  String get taskDetailsTitle => 'Task Details';

  @override
  String get editTask => 'Edit';

  @override
  String get deleteTask => 'Delete';

  @override
  String get deleteConfirmationTitle => 'Delete Task?';

  @override
  String get deleteConfirmationBody =>
      'Are you sure you want to delete this task?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get editTaskTitle => 'Edit Task';

  @override
  String get updateTaskButton => 'Update Task';

  @override
  String get categoryTask => 'Task';

  @override
  String get taskCreatedToast => 'Task created successfully!';

  @override
  String get taskUpdatedToast => 'Task updated!';

  @override
  String get taskDeletedToast => 'Task deleted!';

  @override
  String get usernameLabel => 'Username';

  @override
  String get editName => 'Edit Name';

  @override
  String get save => 'Save';
}
