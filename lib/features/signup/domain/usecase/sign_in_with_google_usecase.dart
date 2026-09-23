import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/signup/domain/entities/signup_user.dart';
import 'package:myfarm/features/signup/domain/repo/google_sign_in_repository.dart';

class SignInWithGoogleUseCase {
  final GoogleSignInRepository repository;
  SignInWithGoogleUseCase(this.repository);

  Future<Either<Failure, SignupUser>> call() {
    return repository.signInWithGoogle();
  }
}