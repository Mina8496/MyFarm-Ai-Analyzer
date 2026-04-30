import 'package:myfarm/core/auth/domain/entities/auth_user.dart';
import 'package:myfarm/core/auth/domain/repositories/auth_repository.dart';

class GetAuthStateUseCase {
  final AuthRepository repo;
  const GetAuthStateUseCase(this.repo);

  Stream<AuthUser?> call() => repo.authStateChanges;
}