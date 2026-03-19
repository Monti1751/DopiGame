import 'package:equatable/equatable.dart';
import 'item.dart';

class InventoryItem extends Equatable {
  final int id;
  final Item item;
  final bool isPlaced;
  final double posX;
  final double posY;

  const InventoryItem({
    required this.id,
    required this.item,
    required this.isPlaced,
    required this.posX,
    required this.posY,
  });

  @override
  List<Object?> get props => [id, item, isPlaced, posX, posY];

  InventoryItem copyWith({
    bool? isPlaced,
    double? posX,
    double? posY,
  }) {
    return InventoryItem(
      id: id,
      item: item,
      isPlaced: isPlaced ?? this.isPlaced,
      posX: posX ?? this.posX,
      posY: posY ?? this.posY,
    );
  }
}
