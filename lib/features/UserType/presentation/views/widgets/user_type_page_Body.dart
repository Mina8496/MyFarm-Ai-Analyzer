import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/UserType/presentation/controller/select_user_type_controller.dart';
import 'package:myfarm/features/UserType/presentation/views/widgets/UserTypeView.dart';

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
        Column(
          children: [
            SizedBox(height: 80.h),
            AppTextView(text: 'Please_select_user_type'.tr),
            SizedBox(height: 20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GridView.builder(
                  itemCount: controller.userTypes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 25.h,
                    crossAxisSpacing: 20.w,
                    childAspectRatio: 0.80,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.userTypes[index];
                    final isSelected = controller.selectedType == item.code;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.selectedType = item.code;
                        });
                      },
                      child: UserTypeView(isSelected: isSelected, item: item),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 60.h),

            AppButton(
              controller: controller.selectedType == null
                  ? null
                  : controller.onConfirm,
                  backgroundColor: controller.selectedType == null ? Colors.white.withOpacity(0.2) // شفاف 
                  : ColorPalette.kButtonColor,
              child: AppTextView(text: 'Continue'.tr, color: Colors.white),
            ),

            SizedBox(height: 200.h),
          ],
        ),
      ],
    );
  }
}
