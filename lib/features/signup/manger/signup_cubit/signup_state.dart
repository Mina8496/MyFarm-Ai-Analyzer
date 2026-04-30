import 'package:firebase_auth/firebase_auth.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final User user;
  SignupSuccess(this.user);
}

class SignupError extends SignupState {
  final String message;
  SignupError(this.message);
}
