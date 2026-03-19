import '../../domain/entities/inventory_item.dart';
import 'item_model.dart';

class InventoryItemModel extends InventoryItem {
  const InventoryItemModel({
    required int id,
    required ItemModel item,
    required bool isPlaced,
    required double posX,
    required double posY,
  }) : super(
          id: id,
          item: item,
          isPlaced: isPlaced,
          posX: posX,
          posY: posY,
        );

  factory InventoryItemModel.fromMap(Map<String, dynamic> map, Map<String, dynamic> itemMap) {
    return InventoryItemModel(
      id: map['id'] as int,
      item: ItemModel.fromMap(itemMap),
      isPlaced: (map['is_placed'] as int) == 1,
      posX: (map['pos_x'] as num).toDouble(),
      posY: (map['pos_y'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_id': item.id,
      'is_placed': isPlaced ? 1 : 0,
      'pos_x': posX,
      'pos_y': posY,
    };
  }
}
