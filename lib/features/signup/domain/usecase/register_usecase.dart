import 'package:myfarm/features/signup/auth/domain/entities/RegisterRequest.dart';
import 'package:myfarm/features/signup/domain/repo/signup_repository.dart';

class SignupUseCase {
  final SignupRepository repository;

  SignupUseCase(this.repository);

  Future<void> call(SignupRequest params) {
    return repository.register(params);
  }
}
