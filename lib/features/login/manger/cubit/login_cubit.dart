import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myfarm/features/login/domain/entity/user_entity.dart';
import 'package:myfarm/features/login/domain/use_cases/login_usecase.dart';
import 'package:myfarm/features/login/manger/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordHidden = true;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(LoginPasswordToggled(isPasswordHidden));
  }

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

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final user = userCredential.user;
      if (user == null) {
        emit(LoginError('Google sign-in failed'));
        return;
      }

      emit(
        LoginGoogleSignInSuccess(
          UserEntity(id: user.uid, email: user.email ?? ''),
        ),
      );
    } catch (e) {
      emit(LoginError('Google sign-in failed: $e'));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
