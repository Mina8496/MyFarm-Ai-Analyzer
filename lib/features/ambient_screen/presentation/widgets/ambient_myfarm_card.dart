import 'package:flutter/material.dart';
import 'ambient_theme.dart';

class AmbientMyFarmCard extends StatelessWidget {
  const AmbientMyFarmCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AmbientTheme.accentLeaf,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'MYFARM',
              style: TextStyle(
                color: AmbientTheme.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Smart Plant Monitoring',
          style: TextStyle(
            color: AmbientTheme.accentGold,
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
