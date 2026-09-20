import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_state.dart';
import 'package:myfarm/core/utils/styles.dart';

class AccountHeaderCard extends StatelessWidget {
  const AccountHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        width: double.infinity,
        height: 150.h,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: ColorPalette.kWhiteColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: ColorPalette.kPrimaryGray,
              child: Icon(
                Icons.person,
                size: 40,
                color: ColorPalette.kWhiteColor,
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    return Text(
                      state.user.displayNameOrFallback,
                      style: Styles.style20,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.toNamed('/signup'),
                    child: Text(
                      'تسجيل الدخول / التسجيل',
                      style: Styles.style20.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}