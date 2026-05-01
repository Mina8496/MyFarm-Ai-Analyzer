import 'package:myfarm/core/auth/domain/entities/auth_user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthUser user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthOnboarding extends AuthState {}  

class AuthHome extends AuthState {}  