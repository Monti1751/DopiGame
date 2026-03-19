import '../repositories/sanctuary_repository.dart';

class ToggleItemPlacementUseCase {
  final SanctuaryRepository repository;

  ToggleItemPlacementUseCase(this.repository);

  Future<void> call(int inventoryId, bool isPlaced) async {
    await repository.toggleItemPlacement(inventoryId, isPlaced);
  }
}
