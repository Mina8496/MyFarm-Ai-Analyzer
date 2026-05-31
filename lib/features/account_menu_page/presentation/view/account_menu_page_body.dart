import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/account_menu_page/presentation/view/widgets/authentication_card.dart';
import 'package:myfarm/features/account_menu_page/presentation/view/widgets/account_menu_List.dart';

import '../manager/account_menu_cubit.dart';

class AccountMenuPageBody extends StatelessWidget {
  const AccountMenuPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountMenuCubit, AccountMenuPageState>(
      builder: (context, state) {
        if (state is FeatureLoading || state is FeatureInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FeatureError) {
          return Center(child: Text(state.message));
        }

        return Container(
          decoration: BoxDecoration(color: ColorPalette.kPrimaryColor),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 30.h),

                AuthenticationCard(),

                SizedBox(height: 42.h),

                AccountMenuList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
