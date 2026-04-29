import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/signup/data/dataSource/signup_remote_data_source.dart';
import 'package:myfarm/features/signup/domain/repo/signup_repository.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_params.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource remote;
  const SignupRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, User>> signup(SignupParams params) async {
    try {
      final model = await remote.signup(params);
      return Right(model.toEntity() as User);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
