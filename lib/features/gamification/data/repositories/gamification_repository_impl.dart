import 'package:sqflite/sqflite.dart';
import '../../../../core/database/database_helper.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_category.dart';
import '../../domain/entities/user_stats.dart';
import '../../domain/entities/level_config.dart';
import '../../domain/repositories/gamification_repository.dart';

import '../../../../core/services/notification_service.dart';

class GamificationRepositoryImpl implements GamificationRepository {
  final DatabaseHelper dbHelper;

  GamificationRepositoryImpl(this.dbHelper);

  @override
  Future<void> markTaskAsCompleted(int taskId) async {
    print("Repository: Marking task $taskId as completed");
    final db = await dbHelper.database;
    final result = await db.update(
      'tasks',
      {'is_completed': 1},
      where: 'id = ?',
      whereArgs: [taskId],
    );
    print("Repository: Update result: $result");
    
    // Cancel notification when task is completed
    try {
      await NotificationService().cancelNotification(taskId);
    } catch (e) {
      print("Repository: Non-fatal error cancelling notification: $e");
    }
  }


  @override
  Future<UserStats> getUserStats() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('user_stats', where: 'id = 1');
    if (maps.isNotEmpty) {
      return UserStats(
        currentXp: maps.first['current_xp'] as int,
        currentLevel: maps.first['current_level'] as int,
        totalCompletedTasks: maps.first['total_completed_tasks'] as int,
        avatarPath: maps.first['avatar_path'] as String?,
        username: maps.first['username'] as String? ?? 'Viajero',
      );
    } else {
      throw Exception('User stats not found');
    }
  }

  @override
  Future<LevelConfig> getLevelConfig(int level) async {
    final db = await dbHelper.database;
    final maps = await db.query('level_config', where: 'level = ?', whereArgs: [level]);
    if (maps.isNotEmpty) {
      return LevelConfig(
        level: maps.first['level'] as int,
        xpRequired: maps.first['xp_required'] as int,
      );
    } else {
      // Default fallback
      return LevelConfig(level: level, xpRequired: level * 100);
    }
  }

  @override
  Future<void> updateUserStats({
    required int newXp,
    required int newLevel,
    required bool incrementTotalTasks,
  }) async {
    final db = await dbHelper.database;
    
    // Increment total logically
    int extraTask = incrementTotalTasks ? 1 : 0;
    
    await db.rawUpdate('''
      UPDATE user_stats 
      SET current_xp = ?, 
          current_level = ?, 
          total_completed_tasks = total_completed_tasks + ? 
      WHERE id = 1
    ''', [newXp, newLevel, extraTask]);
  }

  @override
  Future<List<TaskEntity>> getPendingTasks({int? limit, int? offset}) async {
    return _getTasks(0, limit: limit, offset: offset);
  }

  @override
  Future<List<TaskEntity>> getCompletedTasks() async {
    return _getTasks(1);
  }

  Future<List<TaskEntity>> _getTasks(int isCompleted, {int? limit, int? offset}) async {
    final db = await dbHelper.database;
    String query = '''
      SELECT t.*, c.name as category_name, c.base_xp, c.icon_key 
      FROM tasks t
      INNER JOIN task_categories c ON t.category_id = c.id
      WHERE t.is_completed = ?
      ORDER BY t.order_index ASC, t.id DESC
    ''';
    
    List<dynamic> args = [isCompleted];
    if (limit != null) {
      query += ' LIMIT ?';
      args.add(limit);
    }
    if (offset != null) {
      query += ' OFFSET ?';
      args.add(offset);
    }

    final List<Map<String, dynamic>> maps = await db.rawQuery(query, args);

    return List.generate(maps.length, (i) {
      return TaskEntity(
        id: maps[i]['id'] as int,
        categoryId: maps[i]['category_id'] as int,
        title: maps[i]['title'] as String,
        description: maps[i]['description'] as String?,
        dueDate: maps[i]['due_date'] as String,
        isCompleted: (maps[i]['is_completed'] as int) == 1,
        priorityMultiplier: maps[i]['priority_multiplier'] as double,
        orderIndex: maps[i]['order_index'] as int? ?? 0,
        baseXp: maps[i]['base_xp'] as int,
        categoryName: maps[i]['category_name'] as String,
        categoryIconKey: maps[i]['icon_key'] as String,
      );
    });
  }

  @override
  Future<List<TaskCategory>> getCategories() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('task_categories');
    
    return List.generate(maps.length, (i) {
      return TaskCategory(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
        baseXp: maps[i]['base_xp'] as int,
        iconKey: maps[i]['icon_key'] as String,
      );
    });
  }

  @override
  Future<void> addTask({
    required String title,
    required int categoryId,
    required String dueDate,
    String? description,
    double priorityMultiplier = 1.0,
  }) async {
    final db = await dbHelper.database;
    final id = await db.insert(
      'tasks',
      {
        'category_id': categoryId,
        'title': title,
        'description': description,
        'due_date': dueDate,
        'is_completed': 0,
        'priority_multiplier': priorityMultiplier,
        'order_index': 0, // Initially at the top
      },
    );
    
    // Schedule notification for the new task
    _scheduleNotification(id, title, dueDate);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final db = await dbHelper.database;
    await db.update(
      'tasks',
      {
        'category_id': task.categoryId,
        'title': task.title,
        'description': task.description,
        'due_date': task.dueDate,
        'is_completed': task.isCompleted ? 1 : 0,
        'priority_multiplier': task.priorityMultiplier,
        'order_index': task.orderIndex,
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );

    if (task.isCompleted) {
      try {
        await NotificationService().cancelNotification(task.id);
      } catch (e) {
        print("Repository: Non-fatal error cancelling notification: $e");
      }
    } else {
      try {
        _scheduleNotification(task.id, task.title, task.dueDate);
      } catch (e) {
        print("Repository: Non-fatal error scheduling notification: $e");
      }
    }
  }

  @override
  Future<void> deleteTask(int taskId) async {
    final db = await dbHelper.database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
    await NotificationService().cancelNotification(taskId);
  }

  void _scheduleNotification(int id, String title, String dueDateStr) {
    try {
      final dueDate = DateTime.parse(dueDateStr);
      NotificationService().scheduleDeadlineNotification(
        id: id,
        title: '¡No lo olvides!',
        body: 'Hoy es el último día para: $title',
        dueDate: dueDate,
      );
    } catch (e) {
      // Ignore parsing errors
    }
  }


  @override
  Future<void> updateUserAvatar(String avatarPath) async {
    final db = await dbHelper.database;
    await db.update(
      'user_stats',
      {'avatar_path': avatarPath},
      where: 'id = 1',
    );
  }

  @override
  Future<void> updateUsername(String username) async {
    final db = await dbHelper.database;
    await db.update(
      'user_stats',
      {'username': username},
      where: 'id = 1',
    );
  }
  @override
  Future<void> reorderTasks(int oldIndex, int newIndex, List<TaskEntity> currentTasks) async {
    final db = await dbHelper.database;
    final batch = db.batch();
    
    // Create a mutable copy of the lists
    final tasks = List<TaskEntity>.from(currentTasks);
    final item = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, item);
    
    for (int i = 0; i < tasks.length; i++) {
      batch.update(
        'tasks',
        {'order_index': i},
        where: 'id = ?',
        whereArgs: [tasks[i].id],
      );
    }
    await batch.commit(noResult: true);
  }
}
