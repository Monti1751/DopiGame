import 'package:equatable/equatable.dart';

class UserStats extends Equatable {
  final int currentXp;
  final int currentLevel;
  final int totalCompletedTasks;
  final String? avatarPath;
  final String username;

  const UserStats({
    required this.currentXp,
    required this.currentLevel,
    required this.totalCompletedTasks,
    this.avatarPath,
    required this.username,
  });

  @override
  List<Object?> get props => [currentXp, currentLevel, totalCompletedTasks, avatarPath, username];
}
