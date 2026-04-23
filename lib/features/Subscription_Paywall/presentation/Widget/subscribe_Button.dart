import 'package:flutter/material.dart';

class SubscribeButton extends StatelessWidget {
  final String text;
  final Gradient? linearGradient;
  final Color color;
  const SubscribeButton({
    super.key,
    required this.text,
    this.linearGradient,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: linearGradient,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
