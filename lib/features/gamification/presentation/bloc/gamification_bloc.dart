import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_category.dart';
import '../../domain/entities/user_stats.dart';
import '../../domain/repositories/gamification_repository.dart';
import '../../domain/usecases/complete_task_usecase.dart';
import 'package:equatable/equatable.dart';

// EVENTS
abstract class GamificationEvent extends Equatable {
  const GamificationEvent();
  @override
  List<Object?> get props => [];
}

class LoadGamificationData extends GamificationEvent {}

class CompleteTaskEvent extends GamificationEvent {
  final TaskEntity task;
  const CompleteTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class CompleteTaskWithLevelUpAckEvent extends GamificationEvent {}

class AddTaskEvent extends GamificationEvent {
  final String title;
  final int categoryId;
  final String dueDate;
  final String? description;
  final double priorityMultiplier;

  const AddTaskEvent({
    required this.title,
    required this.categoryId,
    required this.dueDate,
    this.description,
    this.priorityMultiplier = 1.0,
  });

  @override
  List<Object?> get props => [title, categoryId, dueDate, description, priorityMultiplier];
}

class UpdateTaskEvent extends GamificationEvent {
  final TaskEntity task;
  const UpdateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends GamificationEvent {
  final int taskId;
  const DeleteTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class UpdateAvatarEvent extends GamificationEvent {
  final String avatarPath;
  const UpdateAvatarEvent(this.avatarPath);

  @override
  List<Object?> get props => [avatarPath];
}

class UpdateUsernameEvent extends GamificationEvent {
  final String username;
  const UpdateUsernameEvent(this.username);

  @override
  List<Object?> get props => [username];
}
class ReorderTaskEvent extends GamificationEvent {
  final int oldIndex;
  final int newIndex;
  const ReorderTaskEvent(this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class LoadMoreTasksEvent extends GamificationEvent {}
// STATES
abstract class GamificationState extends Equatable {
  const GamificationState();
  @override
  List<Object?> get props => [];
}

class GamificationInitial extends GamificationState {
  const GamificationInitial();
}

class GamificationLoading extends GamificationState {
  const GamificationLoading();
}

class GamificationLoaded extends GamificationState {
  final UserStats userStats;
  final List<TaskEntity> pendingTasks;
  final List<TaskCategory> categories;
  final bool showLevelUpAnimation;
  final int? newLevel;
  final bool hasReachedMax;

  const GamificationLoaded({
    required this.userStats,
    required this.pendingTasks,
    required this.categories,
    this.showLevelUpAnimation = false,
    this.newLevel,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [userStats, pendingTasks, categories, showLevelUpAnimation, newLevel, hasReachedMax];

  GamificationLoaded copyWith({
    UserStats? userStats,
    List<TaskEntity>? pendingTasks,
    List<TaskCategory>? categories,
    bool? showLevelUpAnimation,
    int? newLevel,
    bool? hasReachedMax,
  }) {
    return GamificationLoaded(
      userStats: userStats ?? this.userStats,
      pendingTasks: pendingTasks ?? this.pendingTasks,
      categories: categories ?? this.categories,
      showLevelUpAnimation: showLevelUpAnimation ?? this.showLevelUpAnimation,
      newLevel: newLevel,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class GamificationError extends GamificationState {
  final String message;
  const GamificationError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLOC
class GamificationBloc extends Bloc<GamificationEvent, GamificationState> {
  final GamificationRepository repository;
  final CompleteTaskUseCase completeTaskUseCase;

  GamificationBloc({
    required this.repository,
    required this.completeTaskUseCase,
  }) : super(const GamificationInitial()) {
    on<LoadGamificationData>(_onLoadGamificationData);
    on<CompleteTaskEvent>(_onCompleteTaskEvent);
    on<CompleteTaskWithLevelUpAckEvent>(_onAcknowledgeLevelUp);
    on<AddTaskEvent>(_onAddTaskEvent);
    on<UpdateTaskEvent>(_onUpdateTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
    on<UpdateAvatarEvent>(_onUpdateAvatarEvent);
    on<UpdateUsernameEvent>(_onUpdateUsernameEvent);
    on<ReorderTaskEvent>(_onReorderTaskEvent);
    on<LoadMoreTasksEvent>(_onLoadMoreTasksEvent);
  }

  Future<void> _onLoadGamificationData(
    LoadGamificationData event,
    Emitter<GamificationState> emit,
  ) async {
    emit(GamificationLoading());
    try {
      final stats = await repository.getUserStats();
      final tasks = await repository.getPendingTasks(limit: 20, offset: 0);
      final categories = await repository.getCategories();
      emit(GamificationLoaded(
        userStats: stats,
        pendingTasks: tasks,
        categories: categories,
        hasReachedMax: tasks.length < 20,
      ));
    } catch (e, stack) {
      print("Error loading gamification data: $e");
      print(stack);
      emit(const GamificationError("Vaya, no hemos podido cargar tus datos. ¿Reintentamos?"));
    }
  }

  Future<void> _onCompleteTaskEvent(
    CompleteTaskEvent event,
    Emitter<GamificationState> emit,
  ) async {
    if (state is GamificationLoaded) {
      final currentState = state as GamificationLoaded;
      try {
        final oldLevel = currentState.userStats.currentLevel;

        await completeTaskUseCase.execute(event.task);
        
        final newStats = await repository.getUserStats();
        final newTasks = await repository.getPendingTasks();
        
        bool leveledUp = newStats.currentLevel > oldLevel;
        
        emit(currentState.copyWith(
          userStats: newStats,
          pendingTasks: newTasks,
          showLevelUpAnimation: leveledUp,
          newLevel: leveledUp ? newStats.currentLevel : null,
        ));
      } catch (e, stack) {
        print("Error completing task: $e");
        print(stack);
      }
    }
  }

  void _onAcknowledgeLevelUp(
    CompleteTaskWithLevelUpAckEvent event,
    Emitter<GamificationState> emit,
  ) {
    if (state is GamificationLoaded) {
      final currentState = state as GamificationLoaded;
      emit(currentState.copyWith(showLevelUpAnimation: false, newLevel: null));
    }
  }

  Future<void> _onAddTaskEvent(
    AddTaskEvent event,
    Emitter<GamificationState> emit,
  ) async {
    if (state is GamificationLoaded) {
      final currentState = state as GamificationLoaded;
      try {
        await repository.addTask(
          title: event.title,
          categoryId: event.categoryId,
          dueDate: event.dueDate,
          description: event.description,
          priorityMultiplier: event.priorityMultiplier,
        );

        // Reload pending tasks
        final newTasks = await repository.getPendingTasks();
        
        emit(currentState.copyWith(pendingTasks: newTasks));
      } catch (e, stack) {
        print("Error adding task: $e");
        print(stack);
      }
    }
  }

  Future<void> _onUpdateTaskEvent(
    UpdateTaskEvent event,
    Emitter<GamificationState> emit,
  ) async {
    if (state is GamificationLoaded) {
      final currentState = state as GamificationLoaded;
      try {
        await repository.updateTask(event.task);
        final newTasks = await repository.getPendingTasks();
        emit(currentState.copyWith(pendingTasks: newTasks));
      } catch (e, stack) {
        print("Error updating task: $e");
        print(stack);
      }
    }
  }

  Future<void> _onDeleteTaskEvent(
    DeleteTaskEvent event,
    Emitter<GamificationState> emit,
  ) async {
    if (state is GamificationLoaded) {
      final currentState = state as GamificationLoaded;
      try {
        await repository.deleteTask(event.taskId);
        final newTasks = await repository.getPendingTasks();
        emit(currentState.copyWith(pendingTasks: newTasks));
      } catch (e, stack) {
        print("Error deleting task: $e");
        print(stack);
      }
    }
  }

  Future<void> _onUpdateAvatarEvent(
    UpdateAvatarEvent event,
    Emitter<GamificationState> emit,
  ) async {
    if (state is GamificationLoaded) {
      final currentState = state as GamificationLoaded;
      try {
        await repository.updateUserAvatar(event.avatarPath);
        final newStats = await repository.getUserStats();
        emit(currentState.copyWith(userStats: newStats));
      } catch (e, stack) {
        print("Error updating avatar: $e");
        print(stack);
      }
    }
  }

  Future<void> _onReorderTaskEvent(
    ReorderTaskEvent event,
    Emitter<GamificationState> emit,
  ) async {
    if (state is GamificationLoaded) {
      final currentState = state as GamificationLoaded;
      try {
        // Optimistic update
        final tasks = List<TaskEntity>.from(currentState.pendingTasks);
        final item = tasks.removeAt(event.oldIndex);
        tasks.insert(event.newIndex, item);
        
        emit(currentState.copyWith(pendingTasks: tasks));
        
        await repository.reorderTasks(event.oldIndex, event.newIndex, currentState.pendingTasks);
      } catch (e, stack) {
        print("Error reordering tasks: $e");
        print(stack);
      }
    }
  }

  Future<void> _onLoadMoreTasksEvent(
    LoadMoreTasksEvent event,
    Emitter<GamificationState> emit,
  ) async {
    if (state is GamificationLoaded) {
      final currentState = state as GamificationLoaded;
      if (currentState.hasReachedMax) return;
      
      try {
        final moreTasks = await repository.getPendingTasks(
          limit: 20,
          offset: currentState.pendingTasks.length,
        );
        
        if (moreTasks.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          emit(currentState.copyWith(
            pendingTasks: currentState.pendingTasks + moreTasks,
            hasReachedMax: moreTasks.length < 20,
          ));
        }
      } catch (e, stack) {
        print("Error loading more tasks: $e");
        print(stack);
      }
    }
  }

  Future<void> _onUpdateUsernameEvent(
    UpdateUsernameEvent event,
    Emitter<GamificationState> emit,
  ) async {
    if (state is GamificationLoaded) {
      final currentState = state as GamificationLoaded;
      try {
        await repository.updateUsername(event.username);
        final newStats = await repository.getUserStats();
        emit(currentState.copyWith(userStats: newStats));
      } catch (e, stack) {
        print("Error updating username: $e");
        print(stack);
      }
    }
  }
}
