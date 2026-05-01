import 'package:myfarm/core/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repo;
  const LogoutUseCase(this.repo);

  Future<void> call() => repo.logout();
}

