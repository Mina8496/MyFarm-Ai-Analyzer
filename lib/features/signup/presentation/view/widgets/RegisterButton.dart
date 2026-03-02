import 'package:flutter/material.dart';
import 'package:myfarm/core/widgets/app_Button.dart';

class RegisterButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? controller;

  const RegisterButton({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(controller: controller, child: child);
  }
}
