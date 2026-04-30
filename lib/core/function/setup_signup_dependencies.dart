import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:myfarm/features/signup/data/dataSource/signup_remote_data_source.dart';
import 'package:myfarm/features/signup/data/repoImp/signup_repository_imp.dart';
import 'package:myfarm/features/signup/domain/repo/signup_repository.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_usecase.dart';
import 'package:myfarm/features/signup/manger/featured_signup_cubit/signup_cubit.dart';


final getIt = GetIt.instance;

void setupSignupDependencies() {
  // Firebase
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

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