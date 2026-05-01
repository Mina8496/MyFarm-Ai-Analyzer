import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

// Auth
import 'package:myfarm/core/auth/data/repositories/auth_repository_impl.dart';
import 'package:myfarm/core/auth/domain/repositories/auth_repository.dart';
import 'package:myfarm/core/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/services/onboarding_service.dart';
import 'package:myfarm/features/boarding/manger/cubit/onboarding_cubit_cubit.dart';

// Login
import 'package:myfarm/features/login/data/datasources/login_remote_data_source.dart';
import 'package:myfarm/features/login/data/repositories/login_repository_impl.dart';
import 'package:myfarm/features/login/domain/repo/login_repo.dart';
import 'package:myfarm/features/login/domain/use_cases/login_usecase.dart';
import 'package:myfarm/features/login/manger/cubit/login_cubit.dart';

// Signup
import 'package:myfarm/features/signup/data/dataSource/signup_remote_data_source.dart';
import 'package:myfarm/features/signup/data/repoImp/signup_repository_imp.dart';
import 'package:myfarm/features/signup/domain/repo/signup_repository.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_usecase.dart';
import 'package:myfarm/features/signup/manger/signup_cubit/signup_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  _setupFirebase();
  _setupAuth();
  _setupLogin();
  _setupSignup();
}

// ─── Auth ───────────────────────────────────────────────
void _setupAuth() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetAuthStateUseCase(getIt()));
  getIt.registerFactory(() => AuthCubit(getIt()));

  getIt.registerLazySingleton(() => OnboardingService());
  getIt.registerFactory(() => OnboardingCubit(getIt()));
}

// ─── Firebase ───────────────────────────────────────────
void _setupFirebase() {
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
}

// ─── Login ──────────────────────────────────────────────
void _setupLogin() {
  // Data
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt()),
  );

  // Domain
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));

  // Presentation — registerFactory عشان كل شاشة تاخد instance جديدة
  getIt.registerFactory(() => LoginCubit(getIt()));
}

// ─── Signup ─────────────────────────────────────────────
void _setupSignup() {
  // Data
  getIt.registerLazySingleton<SignupRemoteDataSource>(
    () => SignupRemoteDataSourceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<SignupRepository>(
    () => SignupRepositoryImpl(getIt()),
  );

  // Domain
  getIt.registerLazySingleton(() => SignupUseCase(getIt()));

  // Presentation
  getIt.registerFactory(() => SignupCubit(getIt()));
}
