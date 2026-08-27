import 'package:flutter/material.dart';
import 'ambient_theme.dart';

class AmbientWeatherCard extends StatelessWidget {
  final String temperature;
  final String condition;
  final IconData icon;

  const AmbientWeatherCard({
    super.key,
    this.temperature = '32°C',
    this.condition = 'Sunny',
    this.icon = Icons.wb_sunny_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AmbientTheme.spaceM,
        vertical: AmbientTheme.spaceS,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AmbientTheme.textSecondary),
          bottom: BorderSide(color: AmbientTheme.textSecondary),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AmbientTheme.accentGold, size: 30),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FIELD CONDITIONS',
                style: TextStyle(
                  color: AmbientTheme.textTertiary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.6,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$temperature · $condition',
                style: const TextStyle(
                  color: AmbientTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
