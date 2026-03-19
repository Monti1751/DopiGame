import '../repositories/sanctuary_repository.dart';
import 'package:dopi_game/features/gamification/domain/repositories/gamification_repository.dart';

class PurchaseItemUseCase {
  final SanctuaryRepository sanctuaryRepository;
  final GamificationRepository gamificationRepository;

  PurchaseItemUseCase(this.sanctuaryRepository, this.gamificationRepository);

  Future<void> call(int itemId) async {
    final stats = await gamificationRepository.getUserStats();
    final catalog = await sanctuaryRepository.getCatalog();
    final item = catalog.firstWhere((i) => i.id == itemId);

    if (stats.currentLevel < item.levelRequired) {
      throw Exception('Nivel insuficiente');
    }

    if (stats.currency < item.cost) {
      throw Exception('Moneda insuficiente');
    }

    // Deduct currency
    await gamificationRepository.updateUserStats(
      newXp: stats.currentXp,
      newLevel: stats.currentLevel,
      incrementTotalTasks: false,
      newCurrency: stats.currency - item.cost,
    );

    // Add to inventory
    await sanctuaryRepository.purchaseItem(itemId);
  }
}
