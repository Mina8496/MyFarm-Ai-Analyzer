import 'package:myfarm/features/login/domain/entity/user_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserEntity user;
  LoginSuccess(this.user);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginPasswordToggled extends LoginState {
  final bool isHidden;

  LoginPasswordToggled(this.isHidden);
}
