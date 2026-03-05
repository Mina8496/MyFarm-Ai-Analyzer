import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/UserType/presentation/controller/select_user_type_controller.dart';
import 'package:myfarm/features/UserType/presentation/views/widgets/UserTypeView.dart';

class GridviewUserType extends StatelessWidget {
  const GridviewUserType({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SelectUserTypeController>();

    return Expanded(
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

            return Obx(() {
              final isSelected = controller.selectedType.value == item.code;

              return GestureDetector(
                onTap: () => controller.selectType(item.code),
                child: UserTypeView(isSelected: isSelected, item: item),
              );
            });
          },
        ),
      ),
    );
  }
}
