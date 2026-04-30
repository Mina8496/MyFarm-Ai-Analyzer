import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/login/domain/use_cases/login_usecase.dart';
import 'package:myfarm/features/login/manger/cubit/login_cubit_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await loginUseCase(email, password);
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
