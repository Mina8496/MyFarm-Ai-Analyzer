import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:myfarm/core/auth/domain/usecases/logout_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetAuthStateUseCase getAuthStateUseCase;
  final LogoutUseCase logoutUseCase;
  StreamSubscription? _subscription;

  AuthCubit(this.getAuthStateUseCase, this.logoutUseCase)
    : super(AuthInitial()) {
    _init();
  }

  void _init() {
    _subscription = getAuthStateUseCase().listen((user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(AuthUnauthenticated());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
