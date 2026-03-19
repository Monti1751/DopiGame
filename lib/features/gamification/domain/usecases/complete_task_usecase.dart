import '../entities/task.dart';
import '../repositories/gamification_repository.dart';

class CompleteTaskUseCase {
  final GamificationRepository repository;

  CompleteTaskUseCase(this.repository);

  // Ejecuta la lógica de completar tarea y retorno de progreso
  Future<void> execute(TaskEntity task) async {
    // 1. Marcar tarea como completada en DB
    await repository.markTaskAsCompleted(task.id);

    // 2. Obtener stats actuales del usuario
    final stats = await repository.getUserStats();
    final config = await repository.getLevelConfig(stats.currentLevel);

    // 3. Calcular nuevo XP
    int earnedXp = (task.baseXp * task.priorityMultiplier).round();
    int newXp = stats.currentXp + earnedXp;
    int newLevel = stats.currentLevel;

    // 4. Lógica de Level Up
    if (newXp >= config.xpRequired) {
      newXp -= config.xpRequired;
      newLevel++;
    }

    // 5. Reward currency (e.g., 50% of XP earned)
    final int currencyEarned = (earnedXp * 0.5).ceil();
    final int newCurrency = stats.currency + currencyEarned;

    // 6. Persistir cambios
    await repository.updateUserStats(
      newXp: newXp,
      newLevel: newLevel,
      incrementTotalTasks: true,
      newCurrency: newCurrency,
    );
  }
}
