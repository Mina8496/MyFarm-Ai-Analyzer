import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: unused_import
import 'package:collection/collection.dart';
import 'package:myfarm/core/routes/app_pages.dart'; // for firstWhereOrNull

class UserTypeSelectionPage extends StatefulWidget {
  const UserTypeSelectionPage({super.key});

  @override
  State<UserTypeSelectionPage> createState() => _UserTypeSelectionPageState();
}

class _UserTypeSelectionPageState extends State<UserTypeSelectionPage> {
  String selectedType = '';

  final List<Map<String, String>> userTypes = [
    {
      'title': 'Farmer'.tr,
      'image': 'assets/usertype/flah.avif',
      'code': 'farmer',
      'route': '/homeMain',
    },
    {
      'title': 'Supervisor'.tr,
      'image': 'assets/usertype/moshraf.avif',
      'code': 'supervisor',
      'route': '/homeMain',
    },
    {
      'title': 'Farm Owner'.tr,
      'image': 'assets/usertype/owner.avif',
      'code': 'owner',
      'route': '/homeMain',
    },
    {
      'title': 'Doctor'.tr,
      'image': 'assets/usertype/Doctor.avif',
      'code': 'doctor',
      'route': '/homeMain',
    },
    {
      'title': 'Engineer'.tr,
      'image': 'assets/usertype/engner.avif',
      'code': 'engineer',
      'route': '/homeMain',
    },
  ];

  void onConfirm() {
    final selected = userTypes.firstWhereOrNull(
      (element) => element['code'] == selectedType,
    );

    // لو مفيش اختيار
    if (selected == null) {
      Get.snackbar(
        'Error'.tr,
        'Please select a user type first.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    final routeName = selected['route'] ?? '';

    // لو الروت فاضي
    if (routeName.isEmpty) {
      Get.snackbar(
        'Error'.tr,
        'Route not found.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // لو الروت مش موجود في AppPages
    if (!AppPages.pages.any((p) => p.name == routeName)) {
      Get.snackbar(
        'Error'.tr,
        'Route not found.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    Get.offAllNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.all(12.0.dg),
              child: Text(
                'Discover'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GridView.builder(
                  itemCount: userTypes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 25.h,
                    crossAxisSpacing: 20.w,
                    childAspectRatio: 0.80,
                  ),
                  itemBuilder: (context, index) {
                    final item = userTypes[index];
                    final isSelected = selectedType == item['code'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = item['code']!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.amber.withOpacity(1.0)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          border: isSelected
                              ? Border.all(color: Colors.amber, width: 3)
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(5, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 80.h,
                              child: Image.asset(
                                item['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              item['title']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 60.h),
            ElevatedButton(
              onPressed: selectedType.isEmpty ? null : onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Text(
                'continue'.tr,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 200.h),
          ],
        ),
      ),
    );
  }
}
