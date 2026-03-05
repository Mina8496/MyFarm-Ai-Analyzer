import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/UserType/presentation/viewModel/user_types.dart';
import 'package:myfarm/features/UserType/presentation/views/widgets/UserTypeViewItem.dart';

class UserTypeView extends StatelessWidget {
  const UserTypeView({super.key, required this.isSelected, required this.item});

  final bool isSelected;
  final UserType item;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      transform: Matrix4.identity()..scale(isSelected ? 1.05 : 1.0),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.kButtonColor : Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: isSelected ? Colors.amber : Colors.transparent,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? AppColors.kButtonColor.withOpacity(0.4)
                : Colors.black.withOpacity(0.1),
            blurRadius: isSelected ? 15 : 5,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: UserTypeViewItem(item: item, isSelected: isSelected),
    );
  }
}
