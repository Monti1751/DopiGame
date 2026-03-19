import '../../../../core/database/database_helper.dart';
import '../../domain/entities/item.dart';
import '../../domain/entities/inventory_item.dart';
import '../../domain/repositories/sanctuary_repository.dart';
import '../models/item_model.dart';
import '../models/inventory_item_model.dart';

class SanctuaryRepositoryImpl implements SanctuaryRepository {
  final DatabaseHelper dbHelper;

  SanctuaryRepositoryImpl(this.dbHelper);

  @override
  Future<List<Item>> getCatalog() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('items_catalog');
    return List.generate(maps.length, (i) => ItemModel.fromMap(maps[i]));
  }

  @override
  Future<List<InventoryItem>> getUserInventory() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT ui.*, ic.name, ic.type, ic.cost, ic.level_required, ic.asset_path
      FROM user_inventory ui
      JOIN items_catalog ic ON ui.item_id = ic.id
    ''');

    return List.generate(maps.length, (i) {
      final itemMap = {
        'id': maps[i]['item_id'],
        'name': maps[i]['name'],
        'type': maps[i]['type'],
        'cost': maps[i]['cost'],
        'level_required': maps[i]['level_required'],
        'asset_path': maps[i]['asset_path'],
      };
      return InventoryItemModel.fromMap(maps[i], itemMap);
    });
  }

  @override
  Future<void> purchaseItem(int itemId) async {
    final db = await dbHelper.database;
    await db.insert('user_inventory', {
      'item_id': itemId,
      'is_placed': 0,
      'pos_x': 0.5,
      'pos_y': 0.5,
    });
  }

  @override
  Future<void> toggleItemPlacement(int inventoryId, bool isPlaced) async {
    final db = await dbHelper.database;
    await db.update(
      'user_inventory',
      {'is_placed': isPlaced ? 1 : 0},
      where: 'id = ?',
      whereArgs: [inventoryId],
    );
  }

  @override
  Future<void> updateItemPosition(int inventoryId, double posX, double posY) async {
    final db = await dbHelper.database;
    await db.update(
      'user_inventory',
      {'pos_x': posX, 'pos_y': posY},
      where: 'id = ?',
      whereArgs: [inventoryId],
    );
  }
}
