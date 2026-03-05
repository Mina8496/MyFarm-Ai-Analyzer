import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/UserType/presentation/controller/select_user_type_controller.dart';
import 'package:myfarm/features/UserType/presentation/views/widgets/action_section_userType_Page.dart';

class UserTypeSelectionPageBody extends StatefulWidget {
  const UserTypeSelectionPageBody({super.key});

  @override
  State<UserTypeSelectionPageBody> createState() =>
      _UserTypeSelectionPageBodyState();
}

class _UserTypeSelectionPageBodyState extends State<UserTypeSelectionPageBody> {
  final controller = Get.put(SelectUserTypeController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Main content
        ActionSectionUserTypePage(controller: controller),
      ],
    );
  }
}
