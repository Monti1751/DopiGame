import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/inventory_item.dart';
import '../../domain/repositories/sanctuary_repository.dart';
import '../../domain/usecases/toggle_item_placement_usecase.dart';

// Events
abstract class SanctuaryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSanctuary extends SanctuaryEvent {}

class TogglePlacementEvent extends SanctuaryEvent {
  final int inventoryId;
  final bool isPlaced;
  TogglePlacementEvent(this.inventoryId, this.isPlaced);
}

class UpdatePositionEvent extends SanctuaryEvent {
  final int inventoryId;
  final double posX;
  final double posY;
  UpdatePositionEvent(this.inventoryId, this.posX, this.posY);
}

// States
abstract class SanctuaryState extends Equatable {
  const SanctuaryState();
  @override
  List<Object?> get props => [];
}

class SanctuaryInitial extends SanctuaryState {
  const SanctuaryInitial();
}

class SanctuaryLoading extends SanctuaryState {
  const SanctuaryLoading();
}

class SanctuaryLoaded extends SanctuaryState {
  final List<InventoryItem> inventory;

  const SanctuaryLoaded(this.inventory);

  @override
  List<Object?> get props => [inventory];
}

class SanctuaryError extends SanctuaryState {
  final String message;
  const SanctuaryError(this.message);
}

// Bloc
class SanctuaryBloc extends Bloc<SanctuaryEvent, SanctuaryState> {
  final SanctuaryRepository repository;
  final ToggleItemPlacementUseCase toggleItemPlacementUseCase;

  SanctuaryBloc({
    required this.repository,
    required this.toggleItemPlacementUseCase,
  }) : super(SanctuaryInitial()) {
    on<LoadSanctuary>(_onLoadSanctuary);
    on<TogglePlacementEvent>(_onTogglePlacement);
    on<UpdatePositionEvent>(_onUpdatePosition);
  }

  Future<void> _onLoadSanctuary(LoadSanctuary event, Emitter<SanctuaryState> emit) async {
    emit(SanctuaryLoading());
    try {
      final inventory = await repository.getUserInventory();
      emit(SanctuaryLoaded(inventory));
    } catch (e) {
      emit(const SanctuaryError('Mmm, no he podido cargar el santuario. ¿Lo intentamos de nuevo?'));
    }
  }

  Future<void> _onTogglePlacement(TogglePlacementEvent event, Emitter<SanctuaryState> emit) async {
    final currentState = state;
    if (currentState is SanctuaryLoaded) {
      // 1. Update local state immediately for instant feedback
      final updatedInventory = currentState.inventory.map((item) {
        if (item.id == event.inventoryId) {
          return item.copyWith(isPlaced: event.isPlaced);
        }
        return item;
      }).toList();
      emit(SanctuaryLoaded(updatedInventory));

      // 2. Persist in background
      try {
        await toggleItemPlacementUseCase(event.inventoryId, event.isPlaced);
      } catch (e) {
        // Option: emit error or revert state if critical
        emit(SanctuaryError(e.toString()));
        emit(currentState); // Revert
      }
    }
  }

  Future<void> _onUpdatePosition(UpdatePositionEvent event, Emitter<SanctuaryState> emit) async {
    final currentState = state;
    if (currentState is SanctuaryLoaded) {
      // 1. Update local state immediately
      final updatedInventory = currentState.inventory.map((item) {
        if (item.id == event.inventoryId) {
          return item.copyWith(posX: event.posX, posY: event.posY);
        }
        return item;
      }).toList();
      emit(SanctuaryLoaded(updatedInventory));

      // 2. Persist in background
      try {
        await repository.updateItemPosition(event.inventoryId, event.posX, event.posY);
      } catch (e) {
        emit(const SanctuaryError('¡Uy! Ha habido un problemilla al guardar.'));
        emit(currentState);
      }
    }
  }
}
