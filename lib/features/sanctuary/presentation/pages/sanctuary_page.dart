import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dopi_game/core/constants/app_constants.dart';
import '../../domain/entities/inventory_item.dart';
import '../../domain/entities/item.dart';
import '../bloc/sanctuary_bloc.dart';
import '../bloc/shop_bloc.dart';
import 'shop_page.dart';
import '../widgets/animated_capybara.dart';
import '../widgets/draggable_furniture.dart';
import '../widgets/cozy_furniture_renderer.dart';
import 'package:dopi_game/l10n/app_localizations.dart';

class SanctuaryPage extends StatefulWidget {
  const SanctuaryPage({Key? key}) : super(key: key);

  @override
  State<SanctuaryPage> createState() => _SanctuaryPageState();
}

class _SanctuaryPageState extends State<SanctuaryPage> {
  @override
  void initState() {
    super.initState();
    // Trigger load once when entering
    context.read<SanctuaryBloc>().add(LoadSanctuary());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.sanctuaryTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShopPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.inventory_2_outlined),
            onPressed: () => _showInventory(context),
          ),
        ],
      ),
      body: BlocBuilder<SanctuaryBloc, SanctuaryState>(
        builder: (context, state) {
          if (state is SanctuaryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SanctuaryLoaded) {
            if (state.inventory.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.park_outlined, size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(l10n.sanctuaryEmpty),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopPage())),
                      child: Text(l10n.sanctuaryBuyFirstBackground),
                    ),
                  ],
                ),
              );
            }

            // Find at least one background
            final backgrounds = state.inventory.where((i) => i.item.type == ItemType.fondo).toList();
            if (backgrounds.isEmpty) {
               return Center(child: Text(l10n.sanctuaryNoBackground));
            }

            final activeBackground = backgrounds.firstWhere(
              (i) => i.isPlaced,
              orElse: () => backgrounds.first,
            );

            final placedFurniture = state.inventory.where((i) => i.item.type == ItemType.mueble && i.isPlaced).toList();

            return Stack(
              children: [
                Positioned.fill(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      activeBackground.item.name == 'Bosque Somnoliento' 
                          ? Colors.green.withOpacity(0.4) 
                          : activeBackground.item.name == 'Jardín Zen' 
                              ? Colors.indigo.withOpacity(0.3)
                              : activeBackground.item.name == 'Cueva de Cristal'
                                  ? Colors.cyan.withOpacity(0.4)
                                  : activeBackground.item.name == 'Noche Estrellada'
                                      ? Colors.deepPurple.withOpacity(0.6)
                                      : activeBackground.item.name == 'Tarde de Otoño'
                                          ? Colors.orange.withOpacity(0.4)
                                          : Colors.transparent,
                      BlendMode.multiply,
                    ),
                    child: Image.asset(
                      activeBackground.item.assetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(color: theme.colorScheme.primaryContainer),
                    ),
                  ),
                ),
                const Center(child: AnimatedCapybara()),
                ...placedFurniture.map((invItem) {
                  return DraggableFurniture(
                    key: ValueKey(invItem.id),
                    inventoryItem: invItem,
                    onPositionChanged: (x, y) {
                      context.read<SanctuaryBloc>().add(UpdatePositionEvent(invItem.id, x, y));
                    },
                  );
                }),
              ],
            );
          } else if (state is SanctuaryError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showInventory(BuildContext context) {
    final sanctuaryBloc = context.read<SanctuaryBloc>();
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadiusCozy)),
        ),
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: BlocBuilder<SanctuaryBloc, SanctuaryState>(
          bloc: sanctuaryBloc,
          builder: (context, state) {
            if (state is SanctuaryLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.sanctuaryInventoryTitle, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppConstants.paddingMedium),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.inventory.length,
                      itemBuilder: (context, index) {
                        final invItem = state.inventory[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: AppConstants.paddingSmall),
                          child: GestureDetector(
                            onTap: () {
                              sanctuaryBloc.add(TogglePlacementEvent(invItem.id, !invItem.isPlaced));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: invItem.isPlaced 
                                      ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                                      : Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                    border: invItem.isPlaced 
                                      ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                                      : null,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: invItem.item.assetPath.startsWith('furniture_')
                                        ? CozyFurnitureRenderer(assetPath: invItem.item.assetPath, size: 60)
                                        : Image.asset(
                                            invItem.item.assetPath,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getLocalizedItemName(invItem.item.name, l10n),
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
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
