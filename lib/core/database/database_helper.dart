import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';
import '../constants/app_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(AppConstants.dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // Use the web-compatible factory when running in the browser
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _createDB,
      onConfigure: _onConfigure,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE user_stats ADD COLUMN avatar_path TEXT');
    }
    if (oldVersion < 3) {
      await db.insert('task_categories', {'name': 'Tarea', 'base_xp': 20, 'icon_key': 'task'});
    }
    if (oldVersion < 4) {
      await db.execute('ALTER TABLE tasks ADD COLUMN order_index INTEGER DEFAULT 0');
    }
    if (oldVersion < 5) {
      await db.execute('ALTER TABLE user_stats ADD COLUMN username TEXT DEFAULT "Viajero"');
    }
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE level_config (
        level INTEGER PRIMARY KEY,
        xp_required INTEGER NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE task_categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        base_xp INTEGER NOT NULL,
        icon_key TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        due_date TEXT NOT NULL,
        is_completed INTEGER DEFAULT 0,
        priority_multiplier REAL DEFAULT 1.0,
        order_index INTEGER DEFAULT 0,
        FOREIGN KEY (category_id) REFERENCES task_categories (id)
    )
    ''');

    await db.execute('''
    CREATE TABLE user_stats (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        current_xp INTEGER DEFAULT 0,
        current_level INTEGER DEFAULT 1,
        total_completed_tasks INTEGER DEFAULT 0,
        avatar_path TEXT,
        username TEXT DEFAULT "Viajero"
    )
    ''');

    await _insertInitialData(db);
  }

  Future _insertInitialData(Database db) async {
    // Basic level configuration
    for (int i = 1; i <= 10; i++) {
        await db.insert('level_config', {'level': i, 'xp_required': i * 100});
    }

    // Default categories
    await db.insert('task_categories', {'name': 'Tarea', 'base_xp': 20, 'icon_key': 'task'});
    await db.insert('task_categories', {'name': 'Cita Médica', 'base_xp': 30, 'icon_key': 'medical'});
    await db.insert('task_categories', {'name': 'Hábito', 'base_xp': 10, 'icon_key': 'habit'});
    await db.insert('task_categories', {'name': 'Evento', 'base_xp': 50, 'icon_key': 'event'});

    // Initial User Stats
    await db.insert('user_stats', {
      'id': 1, 
      'current_xp': 0, 
      'current_level': 1, 
      'total_completed_tasks': 0, 
      'avatar_path': null,
      'username': 'Viajero'
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
