//PlantTips
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Auth
import 'package:myfarm/core/auth/data/repositories/auth_repository_impl.dart';
import 'package:myfarm/core/auth/domain/repositories/auth_repository.dart';
import 'package:myfarm/core/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:myfarm/core/auth/domain/usecases/logout_usecase.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/services/firestore_service.dart';
import 'package:myfarm/core/services/onboarding_service.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/plant_tips_remote_data_source.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/plant_tips_local_data_source.dart';
import 'package:myfarm/features/PlantTip/data/model/plant_tip_model.dart';
import 'package:myfarm/features/PlantTip/data/repo/plant_tips_repository_impl.dart';
import 'package:myfarm/features/PlantTip/data/service/plant_tips_rotation_service.dart';
import 'package:myfarm/features/PlantTip/domin/repo/plant_tips_repository.dart';
import 'package:myfarm/features/PlantTip/presentation/manger/plant_tips_cubit/plant_tips_cubit.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/manger/cubit/subscription_page_cubit.dart';
import 'package:myfarm/features/app_update/data/repositories/firestore_app_update_repository.dart';
import 'package:myfarm/features/app_update/domain/repositories/app_update_repository.dart';
import 'package:myfarm/features/app_update/domain/usecases/check_for_update_usecase.dart';
import 'package:myfarm/features/app_update/presentation/manger/app_update_cubit.dart';
import 'package:myfarm/features/boarding/manger/cubit/onboarding_cubit_cubit.dart';

// Login
import 'package:myfarm/features/login/data/datasources/login_remote_data_source.dart';
import 'package:myfarm/features/login/data/repositories/login_repository_impl.dart';
import 'package:myfarm/features/login/domain/repo/login_repo.dart';
import 'package:myfarm/features/login/domain/use_cases/login_usecase.dart';
import 'package:myfarm/features/login/manger/cubit/login_cubit.dart';

// Group Chat
import 'package:myfarm/features/group_chat/data/datasource/group_chat_remote_datasource.dart';
import 'package:myfarm/features/group_chat/data/repositories/group_chat_repository_impl.dart';
import 'package:myfarm/features/group_chat/domain/repositories/group_chat_repository.dart';
import 'package:myfarm/features/group_chat/domain/usecases/add_group_note_usecase.dart';
import 'package:myfarm/features/group_chat/domain/usecases/create_group_usecase.dart';
import 'package:myfarm/features/group_chat/domain/usecases/get_my_groups_usecase.dart';
import 'package:myfarm/features/group_chat/domain/usecases/join_group_usecase.dart';
import 'package:myfarm/features/group_chat/domain/usecases/watch_group_notes_usecase.dart';
import 'package:myfarm/features/payment/domain/usecase/get_billing_data.dart';

// Signup
import 'package:myfarm/features/signup/data/dataSource/signup_remote_data_source.dart';
import 'package:myfarm/features/signup/data/repo/google_sign_in_repository_impl.dart';
import 'package:myfarm/features/signup/data/repo/signup_repository_imp.dart';
import 'package:myfarm/features/signup/domain/repo/google_sign_in_repository.dart';
import 'package:myfarm/features/signup/domain/repo/signup_repository.dart';
import 'package:myfarm/features/signup/domain/usecase/sign_in_with_google_usecase.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_usecase.dart';
import 'package:myfarm/features/signup/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:myfarm/features/tasks/data/datasource/task_local_datasource.dart';
import 'package:myfarm/features/tasks/data/datasource/task_local_datasource_impl.dart';

import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';
import 'package:myfarm/features/tasks/data/repository/task_repo_impl.dart';
import 'package:myfarm/features/tasks/domin/usecases/add_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/delete_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/edit_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/get_tasks_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/toggle_complete_usecase.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  _setupFirebase();
  _setupTasks();
  _setupAuth();
  _setupLogin();
  _setupGoogleSignInRepository();
  _setupSignup();
  _setupSubscription();
  _setupAppUpdate();
  _setupPlantTips();
  _setupGroupChat();
}

// ─── PlantTips ──────────────────────────────────────────
void _setupPlantTips() {
  getIt.registerLazySingleton<FirestoreService<PlantTipModel>>(
    () => FirestoreService<PlantTipModel>(getIt()),
    instanceName: 'plantTipFirestore',
  );

  getIt.registerLazySingleton<PlantTipsRemoteDataSource>(
    () => PlantTipsRemoteDataSource(getIt(instanceName: 'plantTipFirestore')),
  );

  getIt.registerLazySingleton(() => PlantTipsLocalDataSource());

  getIt.registerLazySingleton<PlantTipsRepository>(
    () => PlantTipsRepositoryImpl(remote: getIt(), local: getIt()),
  );

  getIt.registerLazySingleton(() => PlantTipsRotationService());

  getIt.registerLazySingleton(() => PlantTipsCubit(getIt(), getIt()));
}

// ─── Auth ───────────────────────────────────────────────
void _setupAuth() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetAuthStateUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerFactory(() => AuthCubit(getIt(), getIt()));

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
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));
}

// ─── Google SignIn Repository ────────────────────────────────────────
void _setupGoogleSignInRepository() {
  getIt.registerLazySingleton<GoogleSignInRepository>(
    () => GoogleSignInRepositoryImpl(
      firebaseAuth: getIt(),
      firestore: getIt(),
      googleSignIn: GoogleSignIn.instance,
    ),
  );
  getIt.registerFactory(() => SignInWithGoogleUseCase(getIt()));
}

// ─── Signup ─────────────────────────────────────────────
void _setupSignup() {
  getIt.registerLazySingleton<SignupRemoteDataSource>(
    () => SignupRemoteDataSourceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<SignupRepository>(
    () => SignupRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => SignupUseCase(getIt()));
  getIt.registerFactory(() => SignupCubit(getIt(), getIt()));
}

// ─── Subscription ───────────────────────────────────────
void _setupSubscription() {
  getIt.registerLazySingleton(
    () => GetBillingDataUseCase(getIt(), getIt()),
  );
  getIt.registerFactory(() => SubscriptionCubit(getIt()));
}

// ─── app_update ──────────────────────────────────────────────
void _setupAppUpdate() {
  if (getIt.isRegistered<AppUpdateRepository>()) return;

  getIt.registerLazySingleton<AppUpdateRepository>(
    () => FirestoreAppUpdateRepository(firestore: getIt()),
  );
  getIt.registerLazySingleton<CheckForUpdateUseCase>(
    () => CheckForUpdateUseCase(getIt()),
  );
  getIt.registerFactory<AppUpdateCubit>(() => AppUpdateCubit(getIt()));
}

// ─── Tasks ──────────────────────────────────────────────
void _setupTasks() {
  getIt.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<TaskRepo>(
    () => TaskRepoImpl(getIt<TaskLocalDataSource>()),
  );

  getIt.registerLazySingleton(() => GetTasksUseCase(getIt<TaskRepo>()));
  getIt.registerLazySingleton(() => AddTaskUseCase(getIt<TaskRepo>()));
  getIt.registerLazySingleton(() => DeleteTaskUsecase(getIt<TaskRepo>()));
  getIt.registerLazySingleton(() => EditTaskUseCase(getIt<TaskRepo>()));
  getIt.registerLazySingleton(() => ToggleCompleteUseCase(getIt<TaskRepo>()));
}

// ─── Group Chat ────────────────────────────────────────
void _setupGroupChat() {
  getIt.registerLazySingleton<GroupChatRemoteDataSource>(
    () => GroupChatRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<GroupChatRepository>(
    () => GroupChatRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => CreateGroupUseCase(getIt()));
  getIt.registerLazySingleton(() => JoinGroupUseCase(getIt()));
  getIt.registerLazySingleton(() => WatchGroupNotesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddGroupNoteUseCase(getIt()));
  getIt.registerLazySingleton(() => GetMyGroupsUseCase(getIt()));
}
