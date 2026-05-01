import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/signup/domain/entities/signup_user.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_params.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupUser>> signup(SignupParams params);
}