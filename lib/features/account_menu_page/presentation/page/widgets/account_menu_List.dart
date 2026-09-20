import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_state.dart';
import 'package:myfarm/features/account_menu_page/presentation/page/widgets/account_menu_tile.dart';
import 'package:myfarm/features/account_menu_page/presentation/page/widgets/logout_confirm_dialog.dart';
import 'package:myfarm/features/ambient_screen/presentation/view/ambient_settings_page.dart';

class AccountMenuList extends StatelessWidget {
  const AccountMenuList({super.key});

  void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('قريبًا')));
  }

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showLogoutConfirmDialog(context);
    if (confirmed && context.mounted) {
      context.read<AuthCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = context.select(
      (AuthCubit cubit) => cubit.state is AuthAuthenticated,
    );

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      children: [
        AccountMenuTile(
          icon: Icons.history,
          title: 'سجل الكشف',
          onTap: () => _comingSoon(context),
        ),
        AccountMenuTile(
          icon: Icons.emoji_events_outlined,
          title: 'الارشادات',
          onTap: () => _comingSoon(context),
        ),
        AccountMenuTile(
          icon: Icons.favorite_outline,
          title: 'العناصر المفضلة',
          onTap: () => _comingSoon(context),
        ),
        AccountMenuTile(
          icon: Icons.settings_outlined,
          title: 'الإعدادات',
          onTap: () => _comingSoon(context),
        ),
        AccountMenuTile(
          icon: Icons.dark_mode_outlined,
          title: 'Ambient Screen',
          onTap: () => Get.to(() => const AmbientSettingsPage()),
        ),
        AccountMenuTile(
          icon: Icons.help_outline,
          title: 'المساعدة',
          onTap: () => _comingSoon(context),
        ),
        if (isAuthenticated)
          AccountMenuTile(
            icon: Icons.logout,
            title: 'تسجيل الخروج',
            iconColor: Colors.red,
            onTap: () => _logout(context),
          ),
      ],
    );
  }
}