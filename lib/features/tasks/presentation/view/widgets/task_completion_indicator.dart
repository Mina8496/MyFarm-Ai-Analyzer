import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/theme/app_theme.dart';

class TaskCompletionIndicator extends StatelessWidget {
  const TaskCompletionIndicator({super.key, required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? ColorPalette.kSecondaryGreen : Colors.transparent,
        border: Border.all(
          color: isCompleted
              ? ColorPalette.kSecondaryGreen
              : colors.textSecondary,
          width: 2,
        ),
      ),
      child: isCompleted
          ? const Icon(Icons.check, size: 14, color: ColorPalette.kWhiteColor)
          : null,
    );
  }
}