import '../../domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel({
    required int id,
    required String name,
    required ItemType type,
    required int cost,
    required int levelRequired,
    required String assetPath,
  }) : super(
          id: id,
          name: name,
          type: type,
          cost: cost,
          levelRequired: levelRequired,
          assetPath: assetPath,
        );

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] == 'fondo' ? ItemType.fondo : ItemType.mueble,
      cost: map['cost'] as int,
      levelRequired: map['level_required'] as int,
      assetPath: map['asset_path'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type == ItemType.fondo ? 'fondo' : 'mueble',
      'cost': cost,
      'level_required': levelRequired,
      'asset_path': assetPath,
    };
  }
}
