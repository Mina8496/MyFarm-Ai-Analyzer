import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/button_content.dart';
import 'package:myfarm/features/login/manger/cubit/login_cubit.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onTap: () async => context.read<LoginCubit>().signInWithGoogle(),
      backgroundColor: Colors.white,
      textApp: ButtonContent(
        text: 'Continue with Google',
        col: Colors.black,
        icon: FontAwesomeIcons.google,
      ),
    );
  }
}
