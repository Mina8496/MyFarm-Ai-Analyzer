import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/core/errors/firebase_exception_mapper.dart';
import 'package:myfarm/features/signup/data/dataSource/signup_remote_data_source.dart';
import 'package:myfarm/features/signup/domain/entities/signup_user.dart';
import 'package:myfarm/features/signup/domain/repo/signup_repository.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_params.dart';


class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource remote;
  const SignupRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, SignupUser>> signup(SignupParams params) async {
    try {
      final model = await remote.signup(params);
      return Right(model.toEntity());
    } catch (e) {
      return Left(FirebaseExceptionMapper.map(e));
    }
  }
}
