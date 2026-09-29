import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final base = isDark ? const Color(0xFF0D1512) : const Color(0xFFF4F7F5);
    final blobs = isDark
        ? const [Color(0xFF14503B), Color(0xFF1B3A4B), Color(0xFF2A2F55)]
        : const [Color(0xFFBFE3D2), Color(0xFFCFE0F5), Color(0xFFE6DDF5)];

    return Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: base)),
        _Blob(
          color: blobs[0],
          alignment: const Alignment(-1.0, -0.9),
          size: 380,
        ),
        _Blob(
          color: blobs[1],
          alignment: const Alignment(1.1, -0.2),
          size: 340,
        ),
        _Blob(
          color: blobs[2],
          alignment: const Alignment(-0.6, 1.1),
          size: 400,
        ),
        child,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  final Color color;
  final Alignment alignment;
  final double size;
  const _Blob({
    required this.color,
    required this.alignment,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: 0.75),
                color.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
