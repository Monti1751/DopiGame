import 'package:equatable/equatable.dart';

class TaskCategory extends Equatable {
  final int id;
  final String name;
  final int baseXp;
  final String iconKey;

  const TaskCategory({
    required this.id,
    required this.name,
    required this.baseXp,
    required this.iconKey,
  });

  @override
  List<Object?> get props => [id, name, baseXp, iconKey];
}
