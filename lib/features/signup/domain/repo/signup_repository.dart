import 'package:myfarm/features/signup/auth/domain/entities/RegisterRequest.dart';

abstract class SignupRepository {
  Future<void> register(SignupRequest request);
}