import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:myfarm/core/utils/Asset_Paths.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/features/signup/manger/featured_signup_cubit/signup_cubit.dart';
import 'package:myfarm/features/signup/presentation/controller/signup_controller.dart';
import 'package:myfarm/core/widgets/app_header_rich_text.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/signup_action_section.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/signup_input_section.dart';

class SignupPageBody extends GetView<SignupController> {
  const SignupPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SignupCubit>(),
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              AppAuthHeader(
                backgroundImage: AssetPaths.backGround_1,
                title: AppHeaderRichText(
                  title_1: 'Create_Account'.tr,
                  title_2: 'Let’s_Create_Account_Together'.tr,
                ),
              ),
              SignupInputSection(),
              SignupActionSection(),
            ],
          ),
        ),
      ),
    );
  }
}
