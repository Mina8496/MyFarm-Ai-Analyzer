import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/Home/presentation/manger/cubit/main_nav_cubit.dart';

class BuildNavItem extends StatelessWidget {
  final IconData icon;
  final int index;

  const BuildNavItem({
    super.key,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<MainNavCubit>().state;
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => context.read<MainNavCubit>().changePage(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: isActive ? const Color(0xFF0B5D1E) : Colors.grey,
          ),
          const SizedBox(height: 6),
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