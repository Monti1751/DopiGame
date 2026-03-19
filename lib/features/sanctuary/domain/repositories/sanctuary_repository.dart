import '../../domain/entities/item.dart';
import '../../domain/entities/inventory_item.dart';

abstract class SanctuaryRepository {
  Future<List<Item>> getCatalog();
  Future<List<InventoryItem>> getUserInventory();
  Future<void> purchaseItem(int itemId);
  Future<void> toggleItemPlacement(int inventoryId, bool isPlaced);
  Future<void> updateItemPosition(int inventoryId, double posX, double posY);
}
