import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/item.dart';
import '../../domain/usecases/get_unlocked_items_usecase.dart';
import '../../domain/usecases/purchase_item_usecase.dart';
import '../../domain/entities/inventory_item.dart';
import '../../domain/repositories/sanctuary_repository.dart';

// Events
abstract class ShopEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadShop extends ShopEvent {
  final int userLevel;
  LoadShop(this.userLevel);
}

class PurchaseItemEvent extends ShopEvent {
  final int itemId;
  PurchaseItemEvent(this.itemId);
}

// States
abstract class ShopState extends Equatable {
  const ShopState();
  @override
  List<Object?> get props => [];
}

class ShopInitial extends ShopState {
  const ShopInitial();
}

class ShopLoading extends ShopState {
  const ShopLoading();
}

class ShopLoaded extends ShopState {
  final List<Item> catalog;
  final List<int> purchasedItemIds;

  const ShopLoaded({required this.catalog, required this.purchasedItemIds});

  @override
  List<Object?> get props => [catalog, purchasedItemIds];
}

class ShopError extends ShopState {
  final String message;
  const ShopError(this.message);
}

class PurchaseSuccess extends ShopState {
  const PurchaseSuccess();
}

// Bloc
class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetUnlockedItemsUseCase getUnlockedItemsUseCase;
  final PurchaseItemUseCase purchaseItemUseCase;
  final SanctuaryRepository sanctuaryRepository;

  ShopBloc({
    required this.getUnlockedItemsUseCase,
    required this.purchaseItemUseCase,
    required this.sanctuaryRepository,
  }) : super(ShopInitial()) {
    on<LoadShop>(_onLoadShop);
    on<PurchaseItemEvent>(_onPurchaseItem);
  }

  Future<void> _onLoadShop(LoadShop event, Emitter<ShopState> emit) async {
    emit(ShopLoading());
    try {
      final catalog = await getUnlockedItemsUseCase(event.userLevel);
      final inventory = await sanctuaryRepository.getUserInventory();
      final purchasedIds = inventory.map((i) => i.item.id).toList();
      emit(ShopLoaded(catalog: catalog, purchasedItemIds: purchasedIds));
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }

  Future<void> _onPurchaseItem(PurchaseItemEvent event, Emitter<ShopState> emit) async {
    final currentState = state;
    if (currentState is ShopLoaded) {
      try {
        await purchaseItemUseCase(event.itemId);
        emit(PurchaseSuccess());
        // Reload shop after purchase
        // Note: In a real app, you'd pass level from somewhere or store it
      } catch (e) {
        emit(const ShopError('Vaya, no he podido completar la compra. ¿Tienes suficientes monedas?'));
        // Restore loaded state after error message
        emit(currentState);
      }
    }
  }
}
