import 'package:equatable/equatable.dart';

class UserStats extends Equatable {
  final int currentXp;
  final int currentLevel;
  final int totalCompletedTasks;
  final String? avatarPath;
  final String username;
  final int currency;

  const UserStats({
    required this.currentXp,
    required this.currentLevel,
    required this.totalCompletedTasks,
    this.avatarPath,
    required this.username,
    required this.currency,
  });

  @override
  List<Object?> get props => [currentXp, currentLevel, totalCompletedTasks, avatarPath, username, currency];
}
