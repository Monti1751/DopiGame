import 'package:equatable/equatable.dart';

class LevelConfig extends Equatable {
  final int level;
  final int xpRequired;

  const LevelConfig({
    required this.level,
    required this.xpRequired,
  });

  @override
  List<Object?> get props => [level, xpRequired];
}
