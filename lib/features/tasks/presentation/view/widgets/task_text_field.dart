import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/theme/app_theme.dart';
import 'package:myfarm/core/utils/styles.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const TaskTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colors.border),
    );

    return TextField(
      controller: controller,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
      style: Styles.style14.copyWith(color: colors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Styles.style14.copyWith(color: colors.textSecondary),
        filled: true,
        fillColor: colors.card,
        border: border,
        enabledBorder: border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorPalette.kSecondaryGreen,
            width: 2,
          ),
        ),
      ),
    );
  }
}