import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/app_update/domain/usecases/check_for_update_usecase.dart';
import 'package:myfarm/features/app_update/presentation/manger/app_update_state.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdateCubit extends Cubit<AppUpdateState> {
  final CheckForUpdateUseCase checkForUpdateUseCase;

  AppUpdateCubit(this.checkForUpdateUseCase) : super(const AppUpdateState());

  Future<void> checkForUpdate() async {
    emit(state.copyWith(status: AppUpdateStatus.checking));
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = int.tryParse(packageInfo.buildNumber) ?? 0;

      final settings = await checkForUpdateUseCase();
      if (settings == null) {
        emit(state.copyWith(status: AppUpdateStatus.noUpdate));
        return;
      }

      if (currentVersion < settings.minVersion) {
        emit(state.copyWith(
          status: AppUpdateStatus.forceUpdate,
          message: settings.message,
        ));
      } else if (currentVersion < settings.latestVersion) {
        emit(state.copyWith(
          status: AppUpdateStatus.optionalUpdate,
          message: settings.message,
        ));
      } else {
        emit(state.copyWith(status: AppUpdateStatus.noUpdate));
      }
    } catch (_) {
      emit(state.copyWith(status: AppUpdateStatus.error));
    }
  }
}