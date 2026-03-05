import 'package:flutter/material.dart';
import 'package:myfarm/features/Home/presentation/view/controller/main_nev_controller_home.dart';

class BuildNavItem extends StatelessWidget {
  final MainNavController controller;
  final IconData icon;
  final int index;

  const BuildNavItem({
    super.key,
    required this.controller,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: isActive ? const Color(0xFF0B5D1E) : Colors.grey,
          ),
          const SizedBox(height: 6),

          // النقطة تحت الأيقونة
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 6,
            width: isActive ? 6 : 0,
            decoration: const BoxDecoration(
              color: Color(0xFF0B5D1E),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
