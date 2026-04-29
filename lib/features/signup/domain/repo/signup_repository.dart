import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_params.dart';

abstract class SignupRepository {
  Future<Either<Failure, User>> signup(SignupParams params);
}