import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassPage extends StatefulWidget {
  const CompassPage({super.key});

  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  double _heading = 0;
  StreamSubscription<CompassEvent>? _compassSubscription;

  @override
  void initState() {
    super.initState();
    _compassSubscription = FlutterCompass.events?.listen((event) {
      if (!mounted) return;
      if (event.heading != null) {
        setState(() => _heading = event.heading!);
      }
    });
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  String _directionName(double heading) {
    const directions = [
      'شمال',
      'شمال شرقي',
      'شرق',
      'جنوب شرقي',
      'جنوب',
      'جنوب غربي',
      'غرب',
      'شمال غربي',
    ];
    final index = ((heading + 22.5) % 360) ~/ 45;
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    final angle = (_heading) * (math.pi / 180) * -1;

    return Scaffold(
      appBar: AppBar(title: const Text('البوصلة')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 260,
              height: 260,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // القرص الدوّار (الاتجاهات)
                  Transform.rotate(
                    angle: angle,
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: CustomPaint(painter: _CompassDialPainter()),
                    ),
                  ),
                  // السهم الثابت في الأعلى (اتجاه الجهاز)
                  const Icon(
                    Icons.navigation,
                    size: 48,
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${_heading.toStringAsFixed(0)}°',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              _directionName(_heading),
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompassDialPainter extends CustomPainter {
  static const _mainLabels = ['ش', 'ش.ش', 'ق', 'ج.ق', 'ج', 'ج.غ', 'غ', 'ش.غ'];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final tickPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1;

    final majorTickPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;

    // خطوط كل 10 درجات، وخط أعرض كل 30 درجة
    for (int deg = 0; deg < 360; deg += 10) {
      final isMajor = deg % 30 == 0;
      final rad = deg * math.pi / 180;
      final outer = Offset(
        center.dx + radius * math.sin(rad),
        center.dy - radius * math.cos(rad),
      );
      final inner = Offset(
        center.dx + (radius - (isMajor ? 14 : 8)) * math.sin(rad),
        center.dy - (radius - (isMajor ? 14 : 8)) * math.cos(rad),
      );
      canvas.drawLine(inner, outer, isMajor ? majorTickPaint : tickPaint);
    }

    // الاتجاهات الثمانية (ش، ش.ش، ق، ج.ق، ج، ج.غ، غ، ش.غ)
    for (int i = 0; i < 8; i++) {
      final deg = i * 45;
      final rad = deg * math.pi / 180;
      final labelRadius = radius - 32;
      final pos = Offset(
        center.dx + labelRadius * math.sin(rad),
        center.dy - labelRadius * math.cos(rad),
      );

      final isNorth = i == 0;
      final textSpan = TextSpan(
        text: _mainLabels[i],
        style: TextStyle(
          color: isNorth ? Colors.redAccent : Colors.black87,
          fontSize: isNorth ? 18 : 14,
          fontWeight: isNorth ? FontWeight.bold : FontWeight.w500,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.rtl,
      )..layout();
      textPainter.paint(
        canvas,
        pos - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }

    // درجات رقمية كل 30 درجة (اختياري، تحت الحروف)
    for (int deg = 0; deg < 360; deg += 90) {
      final rad = deg * math.pi / 180;
      final numRadius = radius - 52;
      final pos = Offset(
        center.dx + numRadius * math.sin(rad),
        center.dy - numRadius * math.cos(rad),
      );
      final textPainter = TextPainter(
        text: TextSpan(
          text: '$deg°',
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        pos - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
