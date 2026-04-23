import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/widgets/app_textView.dart';

class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_box, color: ColorPalette.kkPrimaryGreen),
          const SizedBox(width: 10),
          AppText(text: text, fontSize: 15, color: Colors.black),
        ],
      ),
    );
  }
}
