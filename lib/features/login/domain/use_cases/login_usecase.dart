import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/login/domain/entity/user_entity.dart';
import 'package:myfarm/features/login/domain/repo/login_repo.dart';

class LoginUseCase {
  final LoginRepository loginRepo;

  LoginUseCase(this.loginRepo);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return loginRepo.login(email, password);
  }
}
