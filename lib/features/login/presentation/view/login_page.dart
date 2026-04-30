import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:myfarm/features/login/manger/cubit/login_cubit.dart';
import 'package:myfarm/features/login/presentation/view/controller/login_controller.dart';
import 'package:myfarm/features/login/presentation/view/widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return BlocProvider(
      create: (context) => GetIt.I<LoginCubit>(),
      child: Scaffold(
        body: FadeTransition(
          opacity: controller.fadeAnimation,
          child: LoginPageBody(),
        ),
      ),
    );
  }
}
