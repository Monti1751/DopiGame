// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'DopiGame';

  @override
  String get welcomeMessage => 'Olá, aventureiro! O que faremos hoje?';

  @override
  String get taskCompleted => 'Tarefa concluída!';

  @override
  String xpGained(int xp) {
    return 'Você ganhou $xp pontos de experiência';
  }

  @override
  String levelUp(int level) {
    return 'Você subiu para o nível $level!';
  }

  @override
  String get categoryMedical => 'Consulta Médica';

  @override
  String get categoryHabit => 'Hábito Diário';

  @override
  String get categoryEvent => 'Evento Especial';

  @override
  String get noTasks =>
      'Tudo calmo por aqui... Tome um chá ou adicione uma tarefa.';

  @override
  String statsLevel(Object level) {
    return 'Nível $level';
  }

  @override
  String get statsProgress => 'Progresso de nível';

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
  String get sanctuaryTitle => 'Santuário';

  @override
  String get sanctuaryEmpty => 'O seu santuário está pronto, mas vazio!';

  @override
  String get sanctuaryBuyFirstBackground => 'Comprar o meu primeiro fundo';

  @override
  String get sanctuaryNoBackground => 'Compre um fundo na loja para começar.';

  @override
  String get sanctuaryInventoryTitle => 'Seu Inventário';

  @override
  String get shopTitle => 'Loja do Santuário';

  @override
  String get shopBuy => 'Comprar';

  @override
  String get shopBought => 'Comprado';

  @override
  String shopItemLevel(int level) {
    return 'Nível $level';
  }

  @override
  String get shopPurchaseSuccess => 'Item comprado!';

  @override
  String get itemForestName => 'Floresta Sonolenta';

  @override
  String get itemZenGardenName => 'Jardim Zen';

  @override
  String get itemJapaneseGardenName => 'Jardim Japonês';

  @override
  String get itemCrystalCaveName => 'Caverna de Cristal';

  @override
  String get itemStarryNightName => 'Noite Estrellada';

  @override
  String get itemAutumnEveningName => 'Tarde de Outono';

  @override
  String get itemCushionName => 'Almofada Confortável';

  @override
  String get itemTeaTableName => 'Mesa de Chá';

  @override
  String get itemPaperLampName => 'Lâmpada de Papel';

  @override
  String get itemSakuraTreeName => 'Árvore de Sakura';

  @override
  String get itemPillowXLName => 'Almofada XL';

  @override
  String get itemStoneLampName => 'Lanterna de Pedra';

  @override
  String get itemBonsaiName => 'Bonsai Milenar';
}
