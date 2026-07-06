import 'package:myfarm/features/signup/domain/entities/signup_user.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final SignupUser signupUser;
  SignupSuccess(this.signupUser);
}

class SignupError extends SignupState {
  final String message;
  SignupError(this.message);
}

class SignupGoogleSignInSuccess extends SignupState {
  final SignupUser signupUser;

  SignupGoogleSignInSuccess(this.signupUser);
}

class SignupPasswordToggled extends SignupState {
  final bool isHidden;
  SignupPasswordToggled(this.isHidden);
}