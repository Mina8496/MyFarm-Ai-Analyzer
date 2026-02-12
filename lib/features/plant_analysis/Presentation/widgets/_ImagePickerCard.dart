import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImagePickerCard extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onPick;

  const ImagePickerCard({
    super.key,
    required this.imageFile,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 150.h,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// IMAGE OR PLACEHOLDER
              imageFile != null
                  ? Image.file(imageFile!, fit: BoxFit.cover)
                  : Container(
                      color: Colors.green.shade50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: 48,
                            color: Colors.green.shade700,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'pick_image'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),

              /// OVERLAY BUTTON
              Positioned(
                bottom: 12.dg,
                right: 12.dg,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.white, size: 16),
                      SizedBox(width: 6.w),
                      Text(
                        'Change'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
