import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/login/domain/use_cases/login_usecase.dart';
import 'package:myfarm/features/login/manger/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login() async {
    emit(LoginLoading());
    final result = await loginUseCase(
      emailController.text.trim(),
      passwordController.text,
    );
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
