import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/theme/app_theme.dart';
import 'package:myfarm/core/utils/styles.dart';

class AccountMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;

  const AccountMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: colors.surface.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(18),
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: iconColor ?? colors.textPrimary),
          title: Text(
            title,
            style: Styles.style18.copyWith(color: colors.textPrimary),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: ColorPalette.kPrimaryGray,
            size: 18,
          ),
        ),
      ),
    );
  }
}
