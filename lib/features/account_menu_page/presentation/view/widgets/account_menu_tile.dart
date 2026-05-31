import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';

class AccountMenuTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;

  const AccountMenuTile({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.18),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: Styles.style18),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: ColorPalette.kkPrimaryGreen,
          size: 18,
        ),
      ),
    );
  }
}
