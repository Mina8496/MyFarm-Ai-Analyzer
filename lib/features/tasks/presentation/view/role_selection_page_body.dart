import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/role_card.dart';

class RoleSelectionBody extends StatelessWidget {
  const RoleSelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        // Header
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: ColorPalette.kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.agriculture, size: 80),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('مزرعتي', style: Styles.style26),
                Text('إدارة المهام الزراعية', style: Styles.style25),
              ],
            ),
          ],
        ),

        SizedBox(height: 8.h),

        Text('اختر دورك', style: Styles.style26),
        SizedBox(height: 8.h),
        Text('كل دور له صلاحيات مختلفة في إدارة المهام', style: Styles.style18),

        SizedBox(height: 10.h),

        // Role Cards
        Expanded(
          child: ListView(
            children: UserRole.values
                .map((role) => RoleCard(role: role))
                .toList(),
          ),
        ),
      ],
    );
  }
}
