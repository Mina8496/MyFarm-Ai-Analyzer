import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
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
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
      style: Styles.style14.copyWith(color: ColorPalette.kWhiteColor),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Styles.style14.copyWith(color: ColorPalette.kWhiteColor),
        filled: true,
        fillColor: ColorPalette.kPrimaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3D5A3C)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3D5A3C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
      ),
    );
  }
}
