import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_it/get_it.dart';
import 'package:myfarm/core/utils/Asset_Paths.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/core/widgets/app_header_rich_text.dart';
import 'package:myfarm/features/signup/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/signup_action_section.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/signup_input_section.dart';

class SignupPageBody extends StatelessWidget {
  const SignupPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SignupCubit>(), 
      child: Builder(
        builder: (context) {
          final cubit = context.read<SignupCubit>();
          return Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppAuthHeader(
                    backgroundImage: AssetPaths.backGround_1,
                    title: AppHeaderRichText(
                      title_1: 'Create_Account'.tr,
                      title_2: "Let’s_Create_Account_Together".tr,
                    ),
                  ),
                  const SignupInputSection(),
                  const SignupActionSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}