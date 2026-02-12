import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralButton extends StatelessWidget {
  final VoidCallback onTap;

  const GeneralButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF3A4048),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'تخطي',
              style: TextStyle(color: Colors.amber, fontSize: 12),
            ),
            SizedBox(width: 6.w),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.amber),
          ],
        ),
      ),
    );
  }
}
