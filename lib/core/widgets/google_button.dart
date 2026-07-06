import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/button_content.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const GoogleButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: onTap,
      backgroundColor: Colors.white,
      textApp: ButtonContent(
        text: 'Continue with Google',
        col: Colors.black,
        icon: FontAwesomeIcons.google,
      ),
    );
  }
}
