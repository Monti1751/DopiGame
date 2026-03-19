import 'package:flutter/material.dart';
import '../../domain/entities/inventory_item.dart';
import './cozy_furniture_renderer.dart';

class DraggableFurniture extends StatefulWidget {
  final InventoryItem inventoryItem;
  final Function(double x, double y) onPositionChanged;

  const DraggableFurniture({
    Key? key,
    required this.inventoryItem,
    required this.onPositionChanged,
  }) : super(key: key);

  @override
  State<DraggableFurniture> createState() => _DraggableFurnitureState();
}

class _DraggableFurnitureState extends State<DraggableFurniture> {
  late double _posX;
  late double _posY;

  @override
  void initState() {
    super.initState();
    _posX = widget.inventoryItem.posX;
    _posY = widget.inventoryItem.posY;
  }

  @override
  void didUpdateWidget(DraggableFurniture oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inventoryItem.posX != widget.inventoryItem.posX ||
        oldWidget.inventoryItem.posY != widget.inventoryItem.posY) {
      setState(() {
        _posX = widget.inventoryItem.posX;
        _posY = widget.inventoryItem.posY;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Positioned(
      left: screenSize.width * _posX - 40,
      top: screenSize.height * _posY - 40,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _posX += details.delta.dx / screenSize.width;
            _posY += details.delta.dy / screenSize.height;
            
            // basic clamping
            _posX = _posX.clamp(0.1, 0.9);
            _posY = _posY.clamp(0.1, 0.9);
          });
        },
        onPanEnd: (details) {
          widget.onPositionChanged(_posX, _posY);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: widget.inventoryItem.item.assetPath.startsWith('furniture_')
              ? CozyFurnitureRenderer(assetPath: widget.inventoryItem.item.assetPath)
              : Image.asset(
                  widget.inventoryItem.item.assetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                ),
        ),
      ),
    );
  }
}
