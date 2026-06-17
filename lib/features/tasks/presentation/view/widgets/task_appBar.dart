import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/presentation/view/role_selection_page.dart';

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
    return AppBar(
      backgroundColor: ColorPalette.kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => _navigateBack(context),
      ),
      title: _RoleTitleColumn(role: role),
      bottom: _TasksTabBar(controller: tabController),
    );
  }

  void _navigateBack(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RoleSelectionPage()),
    );
  }
}

class _RoleTitleColumn extends StatelessWidget {
  final UserRole role;
  const _RoleTitleColumn({required this.role});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المهام الزراعية', style: Styles.styleBold18),
        Row(
          children: [
            Text(role.emoji, style: Styles.style16),
            const SizedBox(width: 4),
            Text(role.displayName, style: Styles.style18),
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
    return TabBar(
      controller: controller,
      indicatorColor: ColorPalette.kkPrimaryGreen,
      labelColor: ColorPalette.kkPrimaryGreen,
      unselectedLabelColor: ColorPalette.kBlackColor,
      labelStyle: Styles.style16,
      tabs: const [
        Tab(text: '⭐ أهم 5 مهام'),
        Tab(text: '📋 كل المهام'),
      ],
    );
  }
}
