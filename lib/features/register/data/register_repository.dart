import 'package:myfarm/features/register/presentation/viewModel/RegisterRequest.dart';

abstract class RegisterRepository {
  Future<void> register(RegisterRequest request);
}