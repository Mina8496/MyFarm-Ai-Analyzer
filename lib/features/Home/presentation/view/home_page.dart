import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/Home/presentation/view/controller/main_nev_controller_home.dart';
import 'package:myfarm/features/Home/presentation/view/widget/custom_bottom_bar.dart';
import 'package:myfarm/features/Home/presentation/view/widget/home_page_body.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(MainNavController());

  final pages = [
    HomePageBody(),
    // const CommunityPage(),
    // const ScanPage(),
    // const PlantsPage(),
    // const ProfilePage(),
  ];
  @override
  Widget build(context) {
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.kButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () => controller.changePage(2),
          child: Card(
            color: AppColors.kButtonColor,
            child: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: CustomBottomBar(controller: controller),
      );
    });
  }
}
