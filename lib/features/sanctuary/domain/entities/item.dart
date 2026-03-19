import 'package:equatable/equatable.dart';

enum ItemType { fondo, mueble }

class Item extends Equatable {
  final int id;
  final String name;
  final ItemType type;
  final int cost;
  final int levelRequired;
  final String assetPath;

  const Item({
    required this.id,
    required this.name,
    required this.type,
    required this.cost,
    required this.levelRequired,
    required this.assetPath,
  });

  @override
  List<Object?> get props => [id, name, type, cost, levelRequired, assetPath];
}
