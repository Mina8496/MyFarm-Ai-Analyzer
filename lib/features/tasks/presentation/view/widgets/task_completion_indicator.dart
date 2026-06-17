import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';

class TaskCompletionIndicator extends StatelessWidget {
  const TaskCompletionIndicator({
    super.key,
    required this.isCompleted,
  });

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted
            ? ColorPalette.kPrimaryColor
            : Colors.transparent,
        border: Border.all(
          color: isCompleted
              ? ColorPalette.kSecondaryGreen
              : ColorPalette.kGreen,
          width: 2,
        ),
      ),
      child: isCompleted
          ? const Icon(
              Icons.check,
              size: 14,
              color: ColorPalette.kWhiteColor,
            )
          : null,
    );
  }
}