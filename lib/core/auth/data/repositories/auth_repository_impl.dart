import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:myfarm/core/auth/domain/entities/auth_user.dart';
import 'package:myfarm/core/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final fb.FirebaseAuth auth;
  const AuthRepositoryImpl(this.auth);

  @override
  Stream<AuthUser?> get authStateChanges {
    return auth.authStateChanges().map((user) {
      if (user == null) return null;
      return AuthUser(id: user.uid, email: user.email!);
    });
  }
}