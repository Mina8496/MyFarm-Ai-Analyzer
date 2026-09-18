//PlantTips
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

// Auth
import 'package:myfarm/core/auth/data/repositories/auth_repository_impl.dart';
import 'package:myfarm/core/auth/domain/repositories/auth_repository.dart';
import 'package:myfarm/core/auth/domain/usecases/get_auth_state_usecase.dart';
import 'package:myfarm/core/auth/domain/usecases/logout_usecase.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/services/firestore_service.dart';
import 'package:myfarm/core/services/onboarding_service.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/PlantTipsRemoteDataSource.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/plantTips_local_data_source.dart';
import 'package:myfarm/features/PlantTip/data/model/plantTip_model.dart';
import 'package:myfarm/features/PlantTip/data/repo/plantTips_repository_Impl.dart';
import 'package:myfarm/features/PlantTip/data/service/PlantTips_rotation_service.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';
import 'package:myfarm/features/PlantTip/presentation/manger/plant_tips_cubit/plant_tips_cubit.dart';
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

// shared_notes
import 'package:myfarm/features/shared_notes/data/datasource/notes_group_remote_datasource.dart';
import 'package:myfarm/features/shared_notes/data/local/joined_groups_storage.dart';
import 'package:myfarm/features/shared_notes/data/repositories/notes_group_repository_impl.dart';
import 'package:myfarm/features/shared_notes/data/repositories/joined_groups_repository_impl.dart';
import 'package:myfarm/features/shared_notes/domain/repositories/notes_group_repository.dart';
import 'package:myfarm/features/shared_notes/domain/repositories/joined_groups_repository.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/add_group_note_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/create_group_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/join_group_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/watch_group_notes_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/get_joined_groups_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/save_joined_group_usecase.dart';

// Signup
import 'package:myfarm/features/signup/data/dataSource/signup_remote_data_source.dart';
import 'package:myfarm/features/signup/data/repoImp/signup_repository_imp.dart';
import 'package:myfarm/features/signup/domain/repo/signup_repository.dart';
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
  _setupSignup();
  _setupAppUpdate();
  _setupPlantTips();
  _setupSharedNotes();
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

// ─── Signup ─────────────────────────────────────────────
void _setupSignup() {
  getIt.registerLazySingleton<SignupRemoteDataSource>(
    () => SignupRemoteDataSourceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<SignupRepository>(
    () => SignupRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => SignupUseCase(getIt()));
  getIt.registerFactory(() => SignupCubit(getIt()));
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

// ─── SharedNotes ────────────────────────────────────────
void _setupSharedNotes() {
  // Notes (Firestore)
  getIt.registerLazySingleton<NotesGroupRemoteDataSource>(
    () => NotesGroupRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<NotesGroupRepo>(
    () => NotesGroupRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => CreateGroupUseCase(getIt()));
  getIt.registerLazySingleton(() => JoinGroupUseCase(getIt()));
  getIt.registerLazySingleton(() => WatchGroupNotesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddGroupNoteUseCase(getIt()));

  // Joined groups (local storage)
  getIt.registerLazySingleton(() => JoinedGroupsLocalDataSource());
  getIt.registerLazySingleton<JoinedGroupsRepository>(
    () => JoinedGroupsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetJoinedGroupsUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveJoinedGroupUseCase(getIt()));
}
