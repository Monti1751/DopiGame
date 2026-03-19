import '../entities/item.dart';
import '../repositories/sanctuary_repository.dart';

class GetUnlockedItemsUseCase {
  final SanctuaryRepository repository;

  GetUnlockedItemsUseCase(this.repository);

  Future<List<Item>> call(int userLevel) async {
    final catalog = await repository.getCatalog();
    return catalog.where((item) => item.levelRequired <= userLevel).toList();
  }
}
