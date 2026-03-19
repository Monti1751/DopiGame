import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dopi_game/features/sanctuary/presentation/bloc/sanctuary_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/item.dart';
import '../bloc/shop_bloc.dart';
import 'package:dopi_game/features/gamification/presentation/bloc/gamification_bloc.dart';
import '../widgets/cozy_furniture_renderer.dart';
import 'package:dopi_game/l10n/app_localizations.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final userStats = (context.read<GamificationBloc>().state as GamificationLoaded).userStats;

    return BlocProvider.value(
      value: context.read<ShopBloc>()..add(LoadShop(userStats.currentLevel)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.shopTitle),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on, color: Colors.orange),
                  const SizedBox(width: 4),
                  BlocBuilder<GamificationBloc, GamificationState>(
                    builder: (context, state) {
                      if (state is GamificationLoaded) {
                        return Text(
                          '${state.userStats.currency}',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        );
                      }
                      return const Text('0');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: BlocConsumer<ShopBloc, ShopState>(
          listener: (context, state) {
            if (state is PurchaseSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.shopPurchaseSuccess)),
              );
              context.read<GamificationBloc>().add(LoadGamificationData());
              context.read<ShopBloc>().add(LoadShop(userStats.currentLevel));
              context.read<SanctuaryBloc>().add(LoadSanctuary());
            } else if (state is ShopError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: theme.colorScheme.error),
              );
            }
          },
          builder: (context, state) {
            if (state is ShopLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShopLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: AppConstants.paddingMedium,
                  mainAxisSpacing: AppConstants.paddingMedium,
                ),
                itemCount: state.catalog.length,
                itemBuilder: (context, index) {
                  final item = state.catalog[index];
                  final isPurchased = state.purchasedItemIds.contains(item.id);
                  return _ItemCard(item: item, isPurchased: isPurchased);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final Item item;
  final bool isPurchased;

  const _ItemCard({required this.item, required this.isPurchased});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: theme.colorScheme.primaryContainer.withOpacity(0.2),
              child: Stack(
                children: [
                   Center(
                    child: item.assetPath.startsWith('furniture_')
                      ? CozyFurnitureRenderer(assetPath: item.assetPath, size: 80)
                      : item.assetPath.isEmpty
                        ? const Icon(Icons.image, size: 50, color: Colors.grey)
                        : Image.asset(
                            item.assetPath,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                          ),
                  ),
                  if (isPurchased)
                    Container(
                      color: Colors.black26,
                      child: const Center(
                        child: Icon(Icons.check_circle, color: Colors.white, size: 40),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getLocalizedItemName(item.name, AppLocalizations.of(context)!),
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.monetization_on, size: 16, color: Colors.orange),
                        const SizedBox(width: 2),
                        Text('${item.cost}', style: theme.textTheme.bodySmall),
                      ],
                    ),
                    Text(l10n.shopItemLevel(item.levelRequired), style: theme.textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: isPurchased 
                      ? null 
                      : () => context.read<ShopBloc>().add(PurchaseItemEvent(item.id)),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      backgroundColor: isPurchased ? Colors.grey : const Color(AppConstants.colorTerracotta),
                    ),
                    child: Text(isPurchased ? l10n.shopBought : l10n.shopBuy),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedItemName(String name, AppLocalizations l10n) {
    switch (name) {
      case 'Bosque Somnoliento': return l10n.itemForestName;
      case 'Jardín Zen': return l10n.itemZenGardenName;
      case 'Jardín Japonés': return l10n.itemJapaneseGardenName;
      case 'Cueva de Cristal': return l10n.itemCrystalCaveName;
      case 'Noche Estrellada': return l10n.itemStarryNightName;
      case 'Tarde de Otoño': return l10n.itemAutumnEveningName;
      case 'Cojín Cómodo': return l10n.itemCushionName;
      case 'Mesa de Té': return l10n.itemTeaTableName;
      case 'Lámpara de Papel': return l10n.itemPaperLampName;
      case 'Árbol de Sakura': return l10n.itemSakuraTreeName;
      case 'Almohada XL': return l10n.itemPillowXLName;
      case 'Farol de Piedra': return l10n.itemStoneLampName;
      case 'Bonsai Milenario': return l10n.itemBonsaiName;
      default: return name;
    }
  }
}
