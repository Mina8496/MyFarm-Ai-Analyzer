import 'package:flutter/material.dart';
import 'ambient_growth_ring.dart';
import 'ambient_theme.dart';

class AmbientClock extends StatelessWidget {
  final String time;

  const AmbientClock({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const AmbientGrowthRing(size: 250),
        Text(
          time,
          style: const TextStyle(
            color: AmbientTheme.textPrimary,
            fontSize: 78,
            fontWeight: FontWeight.w600,
            letterSpacing: -2,
            height: 1,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
