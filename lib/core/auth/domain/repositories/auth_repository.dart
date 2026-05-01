import 'package:myfarm/core/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;
  Future<void> logout();
}