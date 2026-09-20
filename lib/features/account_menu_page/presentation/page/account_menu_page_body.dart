import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/account_menu_page/presentation/page/widgets/account_header_card.dart';
import 'package:myfarm/features/account_menu_page/presentation/page/widgets/account_menu_list.dart';

class AccountMenuPageBody extends StatelessWidget {
  const AccountMenuPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.kPrimaryColor,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            const AccountHeaderCard(),
            SizedBox(height: 42.h),
            const Expanded(child: AccountMenuList()),
          ],
        ),
      ),
    );
  }
}