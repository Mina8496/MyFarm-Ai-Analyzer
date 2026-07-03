import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myfarm/features/login/manger/cubit/login_cubit.dart';
import 'package:myfarm/features/login/presentation/view/widgets/login_page_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<LoginCubit>(),
      child: Scaffold(
        body: FadeTransition(
          opacity: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
          child:  LoginPageBody(),
        ),
      ),
    );
  }
}
