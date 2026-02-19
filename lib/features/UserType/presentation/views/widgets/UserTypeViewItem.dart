import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/UserType/presentation/viewModel/user_types.dart';

class UserTypeViewItem extends StatelessWidget {
  const UserTypeViewItem({
    super.key,
    required this.item,
    required this.isSelected,
  });

  final UserType item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80.h,
          child: Image.asset(
            item.image,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 10.h),
        AppTextView(
          text: item.title,
          fontSize: 12.sp,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ],
    );
  }
}