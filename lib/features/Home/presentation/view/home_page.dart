import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/Home/presentation/view/widget/custom_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 70.h,
        width: 70.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorPalette.kprimaryColor,
        ),
        child: Card(
          color: ColorPalette.kButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),

      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
