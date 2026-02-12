import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Pages/home/PlantAnalysisPage.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Pages/home/home.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Pages/image_classification/mango_leaf_disease_detection/tFLite_classifier_page.dart';

class HomeMainShell extends StatefulWidget {
  const HomeMainShell({super.key});

  @override
  State<HomeMainShell> createState() => _HomeMainShellState();
}

class _HomeMainShellState extends State<HomeMainShell> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> pages = const [
    HomePage(),
    TFLiteClassifierPage(),
    PlantAnalysisPage(),
  ];

  Future<void> _handlePop(bool didPop) async {
    if (didPop) return;
    if (currentIndex > 0) {
      setState(() => currentIndex = 0);
    } else {
      final shouldExit = await showModalBottomSheet<bool>(
        isDismissible: false,
        enableDrag: false,
        elevation: 2,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 190,
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Are you sure you want to exit?'.tr,
                        style: GoogleFonts.poppins(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () => Navigator.pop(context, false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10.h),
                        height: 40.h,
                        child: Center(
                          child: Text(
                            'NO'.tr,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2.w),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10.h),
                        height: 40.h,
                        child: Center(
                          child: Text(
                            'YES'.tr,
                            style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );

      if (shouldExit == true) {
        SystemNavigator.pop();
      }
    }
  }

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _handlePop,
      child: Scaffold(
        backgroundColor: Color(0xFF388E3C),
        body: SafeArea(child: pages[currentIndex]),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: currentIndex,
          height: 60.h,
          backgroundColor: Colors.transparent,
          color: Color(0xFF4CAF50),
          buttonBackgroundColor: Colors.green.shade700,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const <Widget>[
            Icon(Icons.home, size: 30, color: Color(0xFFC8E6C9)),
            Icon(Icons.eco, size: 30, color: Color(0xFFC8E6C9)),
            Icon(Icons.analytics, size: 30, color: Color(0xFFC8E6C9)),
          ],
        ),
      ),
    );
  }
}
