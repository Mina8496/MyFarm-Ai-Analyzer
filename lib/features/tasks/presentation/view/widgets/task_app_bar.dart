import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/Home/presentation/view/home_page.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/core/theme/app_theme.dart';

class TasksAppBar extends StatelessWidget implements PreferredSizeWidget {
  final UserRole role;
  final TabController tabController;

  const TasksAppBar({
    super.key,
    required this.role,
    required this.tabController,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      foregroundColor: colors.textPrimary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => _navigateBack(context),
      ),
      title: _RoleTitleColumn(role: role),
      bottom: _TasksTabBar(controller: tabController),
    );
  }

  void _navigateBack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
      (route) => route.isFirst,
    );
  }
}

class _RoleTitleColumn extends StatelessWidget {
  final UserRole role;
  const _RoleTitleColumn({required this.role});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المهام الزراعية',
          style: Styles.styleBold18.copyWith(color: colors.textPrimary),
        ),
        Row(
          children: [
            Text(role.emoji, style: Styles.style16),
            const SizedBox(width: 4),
            Text(
              role.displayName,
              style: Styles.style18.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}

class _TasksTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  const _TasksTabBar({required this.controller});

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TabBar(
      controller: controller,
      indicatorColor: ColorPalette.kSecondaryGreen,
      labelColor: ColorPalette.kSecondaryGreen,
      unselectedLabelColor: colors.textSecondary,
      dividerColor: Colors.transparent,
      labelStyle: Styles.style16,
      isScrollable: true,
      tabs: const [
        Tab(text: '⭐ أهم 5 مهام'),
        Tab(text: '📋 كل المهام'),
        Tab(text: '📝 ملاحظات مشتركة'),
      ],
    );
  }
}
