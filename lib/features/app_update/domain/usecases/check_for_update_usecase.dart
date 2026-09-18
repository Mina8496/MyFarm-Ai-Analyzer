import 'package:myfarm/features/app_update/domain/entities/app_version_settings.dart';
import 'package:myfarm/features/app_update/domain/repositories/app_update_repository.dart';

class CheckForUpdateUseCase {
  final AppUpdateRepository repository;
  const CheckForUpdateUseCase(this.repository);

  Future<AppVersionSettings?> call() => repository.fetchVersionSettings();
}