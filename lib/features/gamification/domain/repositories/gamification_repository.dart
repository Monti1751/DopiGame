import '../entities/task.dart';
import '../entities/task_category.dart';
import '../entities/user_stats.dart';
import '../entities/level_config.dart';

abstract class GamificationRepository {
  Future<void> markTaskAsCompleted(int taskId);
  Future<UserStats> getUserStats();
  Future<LevelConfig> getLevelConfig(int level);
  Future<void> updateUserStats({
    required int newXp,
    required int newLevel,
    required bool incrementTotalTasks,
  });
  Future<List<TaskEntity>> getPendingTasks({int? limit, int? offset});
  Future<List<TaskEntity>> getCompletedTasks();
  Future<List<TaskCategory>> getCategories();
  Future<void> addTask({
    required String title,
    required int categoryId,
    required String dueDate,
    String? description,
    double priorityMultiplier,
  });
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(int taskId);
  Future<void> updateUserAvatar(String avatarPath);
  Future<void> updateUsername(String username);
  Future<void> reorderTasks(int oldIndex, int newIndex, List<TaskEntity> currentTasks);

}
