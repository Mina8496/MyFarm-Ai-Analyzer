import 'package:myfarm/features/ambient_screen/domain/repositories/ambient_screen_service.dart';

import '../../domain/entities/ambient_settings.dart';
import '../../domain/repositories/ambient_repository.dart';
import '../datasources/ambient_local_data_source.dart';
import '../models/ambient_settings_model.dart';

class AmbientRepositoryImpl implements AmbientRepository {
  final AmbientLocalDataSource localDataSource;

  AmbientRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<AmbientSettings> getSettings() {
    return localDataSource.getSettings();
  }

  @override
  Future<void> saveSettings(
    AmbientSettings settings,
  ) async {
    final model =
        AmbientSettingsModel.fromEntity(settings);

    await localDataSource.saveSettings(model);
  }

  @override
  Future<void> closeScreen() async {
    await AmbientScreenService.close();
  }
}