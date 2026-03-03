import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as fontawesome;
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/button_content.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: () async {
        // Google SignIn
      },
      backgroundColor: Colors.white,
      textApp: ButtonContent(
        text: "Continue with Google",
        col: Colors.black,
        icon: fontawesome.FontAwesomeIcons.google,
      ),
    );
  }
}
