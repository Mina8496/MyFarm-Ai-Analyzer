import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_params.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_usecase.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;

  SignupCubit(this.signupUseCase) : super(SignupInitial());

  Future<void> signup(SignupParams params) async {
    emit(SignupLoading());

    final result = await signupUseCase(params);

    result.fold(
      (failure) => emit(SignupError(failure.message)),
      (user) => emit(SignupSuccess(user)),
    );
  }
}
