import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int id;
  final int categoryId;
  final String title;
  final String? description;
  final String dueDate;
  final bool isCompleted;
  final double priorityMultiplier;
  final int orderIndex;
  
  // Extra properties joined from relations
  final int baseXp;
  final String categoryName;
  final String categoryIconKey;

  const TaskEntity({
    required this.id,
    required this.categoryId,
    required this.title,
    this.description,
    required this.dueDate,
    this.isCompleted = false,
    this.priorityMultiplier = 1.0,
    this.orderIndex = 0,
    required this.baseXp,
    required this.categoryName,
    required this.categoryIconKey,
  });

  @override
  List<Object?> get props => [
        id,
        categoryId,
        title,
        description,
        dueDate,
        isCompleted,
        priorityMultiplier,
        orderIndex,
        baseXp,
        categoryName,
        categoryIconKey,
      ];
}
