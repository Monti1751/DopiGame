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
      print("DatabaseHelper: Initializing for Web");
      databaseFactory = databaseFactoryFfiWeb;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("DatabaseHelper: Database path: $path");

    return await openDatabase(
      path,
      version: 8, // Updated dbVersion to 8
      onCreate: (db, version) async {
        print("DatabaseHelper: Creating new database version $version");
        await _createDB(db, version);
      },
      onConfigure: _onConfigure,
      onUpgrade: (db, oldV, newV) async {
        print("DatabaseHelper: Upgrading database from $oldV to $newV");
        await _onUpgrade(db, oldV, newV);
      },
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
    if (oldVersion < 6) {
      // Add currency to user_stats
      await db.execute('ALTER TABLE user_stats ADD COLUMN currency INTEGER DEFAULT 0');
      
      // Create items_catalog table
      await db.execute('''
      CREATE TABLE items_catalog (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          type TEXT NOT NULL,
          cost INTEGER NOT NULL,
          level_required INTEGER NOT NULL,
          asset_path TEXT NOT NULL
      )
      ''');

      // Create user_inventory table
      await db.execute('''
      CREATE TABLE user_inventory (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          item_id INTEGER NOT NULL,
          is_placed INTEGER DEFAULT 0,
          pos_x REAL DEFAULT 0.0,
          pos_y REAL DEFAULT 0.0,
          FOREIGN KEY (item_id) REFERENCES items_catalog (id)
      )
      ''');

      // Insert initial items
      await _insertInitialItems(db);
    }
    if (oldVersion < 7) {
      // Add new items for v7
      await db.insert('items_catalog', {
        'name': 'Jardín Japonés',
        'type': 'fondo',
        'cost': 150,
        'level_required': 4,
        'asset_path': 'assets/images/capybara_tea_party_background.png'
      });

      await db.insert('items_catalog', {
        'name': 'Árbol de Sakura',
        'type': 'mueble',
        'cost': 100,
        'level_required': 3,
        'asset_path': 'furniture_sakura' // Special key for renderer
      });
      
      // Update existing furniture to use special keys for renderer
      await db.update('items_catalog', {'asset_path': 'furniture_cushion'}, where: 'name = ?', whereArgs: ['Cojín Cómodo']);
      await db.update('items_catalog', {'asset_path': 'furniture_table'}, where: 'name = ?', whereArgs: ['Mesa de Té']);
      await db.update('items_catalog', {'asset_path': 'furniture_lamp'}, where: 'name = ?', whereArgs: ['Lámpara de Papel']);
    }
    if (oldVersion < 8) {
      // High-level Backgrounds
      await db.insert('items_catalog', {
        'name': 'Cueva de Cristal',
        'type': 'fondo',
        'cost': 250,
        'level_required': 6,
        'asset_path': 'assets/images/capybara_tea_party_background.png'
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      await db.insert('items_catalog', {
        'name': 'Noche Estrellada',
        'type': 'fondo',
        'cost': 400,
        'level_required': 8,
        'asset_path': 'assets/images/capybara_tea_party_background.png'
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      await db.insert('items_catalog', {
        'name': 'Tarde de Otoño',
        'type': 'fondo',
        'cost': 600,
        'level_required': 10,
        'asset_path': 'assets/images/capybara_tea_party_background.png'
      }, conflictAlgorithm: ConflictAlgorithm.ignore);

      // High-level Furniture
      await db.insert('items_catalog', {
        'name': 'Almohada XL',
        'type': 'mueble',
        'cost': 150,
        'level_required': 5,
        'asset_path': 'furniture_pillow'
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      await db.insert('items_catalog', {
        'name': 'Farol de Piedra',
        'type': 'mueble',
        'cost': 200,
        'level_required': 7,
        'asset_path': 'furniture_stone_lamp'
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
      await db.insert('items_catalog', {
        'name': 'Bonsai Milenario',
        'type': 'mueble',
        'cost': 350,
        'level_required': 9,
        'asset_path': 'furniture_bonsai'
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  Future _insertInitialItems(Database db) async {
    // Backgrounds
    final forestId = await db.insert('items_catalog', {
      'name': 'Bosque Somnoliento',
      'type': 'fondo',
      'cost': 0,
      'level_required': 1,
      'asset_path': 'assets/images/capybara_tea_party_background.png'
    });

    // Add default background to user inventory
    await db.insert('user_inventory', {
      'item_id': forestId,
      'is_placed': 1,
      'pos_x': 0.0,
      'pos_y': 0.0,
    });

    await db.insert('items_catalog', {
      'name': 'Jardín Zen',
      'type': 'fondo',
      'cost': 50,
      'level_required': 3,
      'asset_path': 'assets/images/capybara_tea_party_background.png'
    });

    // Furniture
    await db.insert('items_catalog', {
      'name': 'Cojín Cómodo',
      'type': 'mueble',
      'cost': 10,
      'level_required': 1,
      'asset_path': 'furniture_cushion'
    });
    await db.insert('items_catalog', {
      'name': 'Mesa de Té',
      'type': 'mueble',
      'cost': 30,
      'level_required': 2,
      'asset_path': 'furniture_table'
    });
    await db.insert('items_catalog', {
      'name': 'Lámpara de Papel',
      'type': 'mueble',
      'cost': 20,
      'level_required': 2,
      'asset_path': 'furniture_lamp'
    });
    
    // Level 5-10 additions
    await db.insert('items_catalog', {
      'name': 'Jardín Japonés',
      'type': 'fondo',
      'cost': 150,
      'level_required': 4,
      'asset_path': 'assets/images/capybara_tea_party_background.png'
    });
    await db.insert('items_catalog', {
      'name': 'Árbol de Sakura',
      'type': 'mueble',
      'cost': 100,
      'level_required': 3,
      'asset_path': 'furniture_sakura'
    });
    await db.insert('items_catalog', {
      'name': 'Cueva de Cristal',
      'type': 'fondo',
      'cost': 250,
      'level_required': 6,
      'asset_path': 'assets/images/capybara_tea_party_background.png'
    });
    await db.insert('items_catalog', {
      'name': 'Noche Estrellada',
      'type': 'fondo',
      'cost': 400,
      'level_required': 8,
      'asset_path': 'assets/images/capybara_tea_party_background.png'
    });
    await db.insert('items_catalog', {
      'name': 'Tarde de Otoño',
      'type': 'fondo',
      'cost': 600,
      'level_required': 10,
      'asset_path': 'assets/images/capybara_tea_party_background.png'
    });
    await db.insert('items_catalog', {
      'name': 'Almohada XL',
      'type': 'mueble',
      'cost': 150,
      'level_required': 5,
      'asset_path': 'furniture_pillow'
    });
    await db.insert('items_catalog', {
      'name': 'Farol de Piedra',
      'type': 'mueble',
      'cost': 200,
      'level_required': 7,
      'asset_path': 'furniture_stone_lamp'
    });
    await db.insert('items_catalog', {
      'name': 'Bonsai Milenario',
      'type': 'mueble',
      'cost': 350,
      'level_required': 9,
      'asset_path': 'furniture_bonsai'
    });
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
        username TEXT DEFAULT "Viajero",
        currency INTEGER DEFAULT 0
    )
    ''');

    await db.execute('''
    CREATE TABLE items_catalog (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        cost INTEGER NOT NULL,
        level_required INTEGER NOT NULL,
        asset_path TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE user_inventory (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER NOT NULL,
        is_placed INTEGER DEFAULT 0,
        pos_x REAL DEFAULT 0.0,
        pos_y REAL DEFAULT 0.0,
        FOREIGN KEY (item_id) REFERENCES items_catalog (id)
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
      'username': 'Viajero',
      'currency': 0
    });

    await _insertInitialItems(db);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
