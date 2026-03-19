import 'package:flutter/material.dart';

enum FurnitureType { cushion, table, lamp, sakura, pillow, stone_lamp, bonsai, unknown }

class CozyFurnitureRenderer extends StatelessWidget {
  final String assetPath;
  final double size;

  const CozyFurnitureRenderer({
    Key? key,
    required this.assetPath,
    this.size = 80,
  }) : super(key: key);

  FurnitureType get _type {
    if (assetPath == 'furniture_cushion') return FurnitureType.cushion;
    if (assetPath == 'furniture_table') return FurnitureType.table;
    if (assetPath == 'furniture_lamp') return FurnitureType.lamp;
    if (assetPath == 'furniture_sakura') return FurnitureType.sakura;
    if (assetPath == 'furniture_pillow') return FurnitureType.pillow;
    if (assetPath == 'furniture_stone_lamp') return FurnitureType.stone_lamp;
    if (assetPath == 'furniture_bonsai') return FurnitureType.bonsai;
    return FurnitureType.unknown;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _FurniturePainter(_type),
      ),
    );
  }
}

class _FurniturePainter extends CustomPainter {
  final FurnitureType type;

  _FurniturePainter(this.type);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black.withOpacity(0.1);

    switch (type) {
      case FurnitureType.cushion:
        _drawCushion(canvas, size, paint, strokePaint);
        break;
      case FurnitureType.table:
        _drawTable(canvas, size, paint, strokePaint);
        break;
      case FurnitureType.lamp:
        _drawLamp(canvas, size, paint, strokePaint);
        break;
      case FurnitureType.sakura:
        _drawSakura(canvas, size, paint, strokePaint);
        break;
      case FurnitureType.pillow:
        _drawPillow(canvas, size, paint, strokePaint);
        break;
      case FurnitureType.stone_lamp:
        _drawStoneLamp(canvas, size, paint, strokePaint);
        break;
      case FurnitureType.bonsai:
        _drawBonsai(canvas, size, paint, strokePaint);
        break;
      default:
        _drawPlaceholder(canvas, size, paint);
    }
  }

  void _drawCushion(Canvas canvas, Size size, Paint paint, Paint stroke) {
    paint.color = const Color(0xFFE57373); // Soft red/coral
    final rect = RRect.fromLTRBR(10, 20, size.width - 10, size.height - 10, const Radius.circular(20));
    canvas.drawRRect(rect, paint);
    canvas.drawRRect(rect, stroke);
    
    // Details
    paint.color = Colors.white.withOpacity(0.3);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.4), 5, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.4), 5, paint);
  }

  void _drawTable(Canvas canvas, Size size, Paint paint, Paint stroke) {
    paint.color = const Color(0xFFD7CCC8); // Light wood
    final topRect = RRect.fromLTRBR(5, 30, size.width - 5, 50, const Radius.circular(10));
    canvas.drawRRect(topRect, paint);
    canvas.drawRRect(topRect, stroke);
    
    // Legs
    canvas.drawRect(Rect.fromLTWH(15, 50, 8, 20), paint);
    canvas.drawRect(Rect.fromLTWH(size.width - 23, 50, 8, 20), paint);
  }

  void _drawLamp(Canvas canvas, Size size, Paint paint, Paint stroke) {
    paint.color = const Color(0xFFFFF176); // Soft yellow
    final base = Rect.fromLTWH(size.width * 0.3, size.height * 0.2, size.width * 0.4, size.height * 0.6);
    canvas.drawOval(base, paint);
    canvas.drawOval(base, stroke);
    
    // Glow
    paint.color = Colors.white.withOpacity(0.5);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 10, paint);
  }

  void _drawSakura(Canvas canvas, Size size, Paint paint, Paint stroke) {
    // Trunk
    paint.color = const Color(0xFF5D4037);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.45, size.height * 0.6, size.width * 0.1, size.height * 0.3), paint);
    
    // Leaves (Sakura pink)
    paint.color = const Color(0xFFF48FB1);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 25, paint);
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.5), 18, paint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.5), 18, paint);
  }

  void _drawPillow(Canvas canvas, Size size, Paint paint, Paint stroke) {
    paint.color = const Color(0xFF90CAF9); // Light blue
    final rect = RRect.fromLTRBR(5, 25, size.width - 5, size.height - 15, const Radius.circular(30));
    canvas.drawRRect(rect, paint);
    canvas.drawRRect(rect, stroke);
    
    // Pattern
    paint.color = Colors.white.withOpacity(0.2);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 10, paint);
  }

  void _drawStoneLamp(Canvas canvas, Size size, Paint paint, Paint stroke) {
    paint.color = Colors.grey;
    // Base
    canvas.drawRect(Rect.fromLTWH(size.width * 0.35, size.height * 0.7, size.width * 0.3, size.height * 0.1), paint);
    // Middle
    canvas.drawRect(Rect.fromLTWH(size.width * 0.4, size.height * 0.4, size.width * 0.2, size.height * 0.3), paint);
    // Top
    final trianglePath = Path()
      ..moveTo(size.width * 0.2, size.height * 0.4)
      ..lineTo(size.width * 0.8, size.height * 0.4)
      ..lineTo(size.width * 0.5, size.height * 0.2)
      ..close();
    canvas.drawPath(trianglePath, paint);
    
    // Light
    paint.color = Colors.yellowAccent.withOpacity(0.5);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 5, paint);
  }

  void _drawBonsai(Canvas canvas, Size size, Paint paint, Paint stroke) {
    // Pot
    paint.color = const Color(0xFF795548);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.3, size.height * 0.75, size.width * 0.4, size.height * 0.15), paint);
    
    // Trunk (curved)
    paint.color = const Color(0xFF4E342E);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.45, size.height * 0.5, size.width * 0.1, size.height * 0.25), paint);
    
    // Leaves (dense green)
    paint.color = const Color(0xFF2E7D32);
    canvas.drawOval(Rect.fromLTWH(size.width * 0.25, size.height * 0.3, size.width * 0.5, size.height * 0.3), paint);
  }

  void _drawPlaceholder(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.grey.withOpacity(0.3);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
