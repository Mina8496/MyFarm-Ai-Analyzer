import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myfarm/features/signup/domain/entities/signup_user.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_params.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_usecase.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordHidden = true;

  SignupCubit(this.signupUseCase) : super(SignupInitial());

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(SignupPasswordToggled(isPasswordHidden));
  }

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;

    emit(SignupLoading());

    final params = SignupParams(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      phone: phoneController.text.trim(),
    );

    final result = await signupUseCase(params);

    result.fold(
      (failure) => emit(SignupError(failure.message)),
      (signupUser) => emit(SignupSuccess(signupUser)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(SignupLoading());
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
        emit(SignupError('Google sign-in failed'));
        return;
      }

      emit(
        SignupGoogleSignInSuccess(
          SignupUser(
            id: user.uid,
            email: user.email ?? '',
            name: user.displayName ?? 'Google User',
            phone: user.phoneNumber ?? '',
          ),
        ),
      );
    } catch (e) {
      emit(SignupError('Google sign-in failed: $e'));
    }
  }

  // Validators
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return "Name_required".tr;
    if (value.trim().length < 3)
      return "الاسم قصير جدًا"; // "Name is too short" in Arabic
    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');
    if (!nameRegex.hasMatch(value.trim())) return "Enter valid name";
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return "Phone_required".tr;
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email_required".tr;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter valid email";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) return "Password_min_chars".tr;
    return null;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
