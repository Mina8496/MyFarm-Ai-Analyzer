import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/signup/domain/entities/signup_user.dart';
import 'package:myfarm/features/signup/domain/repo/signup_repository.dart';
import 'signup_params.dart';

class SignupUseCase {
  final SignupRepository repo;
  const SignupUseCase(this.repo);

  Future<Either<Failure, SignupUser>> call(SignupParams params) {
    return repo.signup(params);
  }
}
