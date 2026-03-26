import 'package:flutter/material.dart';
import '../theme.dart';

/// Articulately logo — a speech bubble with a sound wave inside.
/// Drawn entirely with CustomPainter, no image files required.
class AppLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLogo({super.key, this.size = 64, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.colorTextOnColor;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _LogoPainter(c)),
    );
  }
}

class _LogoPainter extends CustomPainter {
  final Color color;
  const _LogoPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..color = color..style = PaintingStyle.fill;

    // Speech bubble body
    final bubbleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h * 0.78),
      Radius.circular(w * 0.22),
    );
    canvas.drawRRect(bubbleRect, paint);

    // Tail (bottom-left triangle)
    final tail = Path()
      ..moveTo(w * 0.15, h * 0.75)
      ..lineTo(w * 0.05, h * 0.98)
      ..lineTo(w * 0.32, h * 0.75)
      ..close();
    canvas.drawPath(tail, paint);

    // Sound wave bars (3 vertical bars of increasing height, centered)
    final barPaint = Paint()
      ..color = color == AppTheme.colorTextOnColor
          ? AppTheme.colorPrimary
          : AppTheme.colorTextOnColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final barW = w * 0.08;
    final barRadius = Radius.circular(barW / 2);
    final centerY = h * 0.38;
    final heights = [h * 0.18, h * 0.30, h * 0.18];
    final startX = w * 0.28;
    final gap = w * 0.14;

    for (int i = 0; i < 3; i++) {
      final bh = heights[i];
      final bx = startX + i * (barW + gap);
      final by = centerY - bh / 2;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(bx, by, barW, bh), barRadius),
        barPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_LogoPainter old) => old.color != color;
}
