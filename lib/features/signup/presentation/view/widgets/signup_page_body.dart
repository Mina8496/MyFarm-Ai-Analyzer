import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/utils/Asset_Paths.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/features/signup/presentation/controller/signup_controller.dart';
import 'package:myfarm/core/widgets/app_header_rich_text.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/signup_action_section.dart';
import 'package:myfarm/features/signup/presentation/view/widgets/signup_input_section.dart';

class SignupPageBody extends GetView<SignupController> {
  const SignupPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            AppAuthHeader(
              backgroundImage: AssetPaths.backGround_1,
              child: AppHeaderRichText(
                title_1: 'Create_Account'.tr,
                title_2: 'Let’s_Create_Account_Together'.tr,
              ),
            ),
            SignupInputSection(),
            SignupActionSection(),
          ],
        ),
      ),
    );
  }
}
