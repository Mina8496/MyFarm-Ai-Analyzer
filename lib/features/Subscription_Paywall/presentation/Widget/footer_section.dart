import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Terms of use | Privacy Policy | Restore".tr,
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}
