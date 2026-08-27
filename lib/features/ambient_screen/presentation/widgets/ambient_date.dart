import 'package:flutter/material.dart';
import 'ambient_theme.dart';

class AmbientDate extends StatelessWidget {
  final String date;

  const AmbientDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      date,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: AmbientTheme.bgGlow,
        fontSize: 16,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}
