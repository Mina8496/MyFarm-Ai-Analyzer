import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/utils/Asset_Paths.dart';

class AuthHeader extends StatelessWidget {
  final Widget child;
  final String? backgroundImage;
  const AuthHeader({required this.child, this.backgroundImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage ?? AssetPaths.backGround_1),
          fit: BoxFit.cover,
          // opacity: 2.9,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(100.r)),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
