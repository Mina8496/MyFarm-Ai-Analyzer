import 'package:flutter/material.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/core/utils/user_role.dart';

class RoleCard extends StatelessWidget {
  final UserRole role;
  const RoleCard({super.key, required this.role});

  Color get _accentColor {
    switch (role) {
      case UserRole.farmer:
        return const Color(0xFF8BC34A);
      case UserRole.engineer:
        return const Color(0xFF29B6F6);
      case UserRole.supervisor:
        return const Color(0xFFFFB300);
      case UserRole.owner:
        return const Color(0xFFEF5350);
    }
  }

  List<String> get _permissions {
    final perms = <String>['✅ إضافة مهام'];
    if (role.canEdit) perms.add('✅ تعديل مهام');
    if (role.canDelete) perms.add('✅ حذف مهام');
    if (!role.canEdit) perms.add('❌ لا يعدّل');
    if (!role.canDelete) perms.add('❌ لا يحذف');
    return perms;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _accentColor.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(role.emoji, style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(role.displayName, style: Styles.style16),
                  const SizedBox(height: 4),
                  Text(role.roleDescription, style: Styles.style16),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _permissions
                        .map((p) => Text(p, style: Styles.style12))
                        .toList(),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: _accentColor.withOpacity(0.6),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
