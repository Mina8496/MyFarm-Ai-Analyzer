import 'package:flutter/material.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/core/widgets/app_text_feild.dart';

class InputField extends StatelessWidget {
  final String? label;
  final String textTitke;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;

  const InputField({
    super.key,
    this.label,
    required this.textTitke,
    required this.controller,
    required this.validator,
    this.onTap,
    this.readOnly = false,
    this.keyboardType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: textTitke, color: Colors.black),
        AppTextField(
          suffixIcon: suffixIcon,
          readOnly: readOnly,
          onTap: onTap,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType ?? TextInputType.text,
        ),
      ],
    );
  }
}
