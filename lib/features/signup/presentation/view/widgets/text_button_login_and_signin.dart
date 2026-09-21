import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';

class TextButtonLoginAndSignin extends StatelessWidget {
  final void Function()? onPressed;
  final String textTitle;
  final String textbutton;

  const TextButtonLoginAndSignin({
    required this.onPressed,
    this.textTitle = "",
    required this.textbutton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.dg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textTitle,
            style: TextStyle(color: Colors.black, fontSize: 15.sp),
          ),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              textbutton,
              style: TextStyle(
                color: ColorPalette.kkPrimaryGreen,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
