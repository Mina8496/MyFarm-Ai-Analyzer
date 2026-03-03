import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/signup/domain/entities/signup_request.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupRequest>> register(SignupRequest request);
}
