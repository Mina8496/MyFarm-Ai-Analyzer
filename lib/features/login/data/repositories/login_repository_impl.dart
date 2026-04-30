import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/login/data/datasources/login_remote_data_source.dart';
import 'package:myfarm/features/login/domain/entity/user_entity.dart';
import 'package:myfarm/features/login/domain/repo/login_repo.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remote;
  const LoginRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final model = await remote.login(email, password);
      return Right(model.toEntity()); // model → entity
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
