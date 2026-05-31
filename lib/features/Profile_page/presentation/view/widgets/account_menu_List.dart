import 'package:flutter/material.dart';
import 'package:myfarm/features/Profile_page/presentation/view/widgets/account_menu_tile.dart';

class AccountMenuList extends StatelessWidget {
  const AccountMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          AccountMenuTile(
            icon: Icons.history,
            title: "سجل الكشف",
            onTap: () {},
          ),
          AccountMenuTile(
            icon: Icons.emoji_events_outlined,
            title: "الارشادات",
            onTap: () {},
          ),
          AccountMenuTile(
            icon: Icons.favorite_outline,
            title: "العناصر المفضلة",
            onTap: () {},
          ),
          AccountMenuTile(
            icon: Icons.settings_outlined,
            title: "الإعدادات",
            onTap: () {},
          ),
          AccountMenuTile(
            icon: Icons.help_outline,
            title: "المساعدة",
            onTap: () {},
          ),
          AccountMenuTile(
            icon: Icons.logout,
            title: "تسجيل الخروج",
            iconColor: Colors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
