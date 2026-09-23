import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/signup/domain/entities/signup_user.dart';

abstract class GoogleSignInRepository {
  Future<Either<Failure, SignupUser>> signInWithGoogle();
}