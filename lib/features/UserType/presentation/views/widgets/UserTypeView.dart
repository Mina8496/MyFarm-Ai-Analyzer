import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/UserType/presentation/viewModel/user_types.dart';
import 'package:myfarm/features/UserType/presentation/views/widgets/UserTypeViewItem.dart';

class UserTypeView extends StatelessWidget {
  const UserTypeView({
    super.key,
    required this.isSelected,
    required this.item,
  });

  final bool isSelected;
  final UserType item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? ColorPalette.kButtonColor.withOpacity(1.0)
            : Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: isSelected
            ? Border.all(color: Colors.amber, width: 3)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5.r,
            offset: const Offset(5, 10),
          ),
        ],
      ),
      child: UserTypeViewItem(item: item, isSelected: isSelected),
    );
  }
}