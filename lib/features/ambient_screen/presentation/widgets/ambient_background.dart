import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';

/// خلفية متدرجة هادئة — أخضر غابة عميق مع توهج مركزي خفيف جدًا.
class AmbientBackground extends StatelessWidget {
  final Widget child;

  const AmbientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.15),
          radius: 1.1,
          colors: [ColorPalette.kSecondaryGreen, ColorPalette.kcardGreen],
          stops: [0.0, 1.0],
        ),
      ),
      child: child,
    );
  }
}
