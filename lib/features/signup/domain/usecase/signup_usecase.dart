import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/signup/domain/entities/signup_request.dart';
import 'package:myfarm/features/signup/domain/repo/signup_repository.dart';

class SignupUseCase  {
  final SignupRepository signRepo;

  SignupUseCase(this.signRepo);

  Future<Either<Failure, SignupRequest>> register(SignupRequest request) {
    return signRepo.register(request);
  }
  
}
