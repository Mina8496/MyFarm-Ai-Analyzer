import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'ambient_theme.dart';

/// حلقة رفيعة جزئية خلف الساعة، مستوحاة من حلقات نمو الشجرة.
/// عنصر تشكيلي ثابت (من غير حركة مستمرة) — يحافظ على البطارية وعلى شاشة AMOLED.
class AmbientGrowthRing extends StatelessWidget {
  final double size;

  const AmbientGrowthRing({super.key, this.size = 260});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GrowthRingPainter()),
    );
  }
}

class _GrowthRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // الحلقة الخارجية الرئيسية — مفتوحة من تحت زي قوس شمس
    final ringPaint = Paint()
      ..color = AmbientTheme.accentGold.withOpacity(0.90)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.2
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 1.15,
      math.pi * 1.7,
      false,
      ringPaint,
    );

    // حلقة داخلية أرفع، أخضر النمو — قوس مقابل
    final innerPaint = Paint()
      ..color = AmbientTheme.accentLeaf.withOpacity(0.50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 18),
      math.pi * 0.1,
      math.pi * 1.1,
      false,
      innerPaint,
    );

    // علامات دقيقة على الحلقة الخارجية — زي علامات الساعات الشمسية
    final tickPaint = Paint()
      ..color = AmbientTheme.textTertiary.withOpacity(0.90)
      ..strokeWidth = 10.0;

    for (int i = 0; i < 12; i++) {
      final angle = (math.pi * 2 / 12) * i;
      final outer = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      final inner = Offset(
        center.dx + (radius - 16) * math.cos(angle),
        center.dy + (radius - 16) * math.sin(angle),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
