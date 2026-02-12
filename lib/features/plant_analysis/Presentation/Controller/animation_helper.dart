import 'package:flutter/material.dart';

class SlideAnimationHelper {
  late final AnimationController controller;
  late final Animation<Offset> animation;

  SlideAnimationHelper({required TickerProvider vsync, Duration? duration}) {
    controller = AnimationController(
      duration: duration ?? const Duration(seconds: 1),
      vsync: vsync,
    );

    animation = Tween<Offset>(
      begin: const Offset(0, 1), // يبدأ من تحت
      end: const Offset(0, 0),   // يصل لمكانه الطبيعي
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    controller.forward();
  }
}
