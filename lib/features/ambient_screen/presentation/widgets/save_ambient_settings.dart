import 'package:myfarm/features/ambient_screen/domain/entities/ambient_settings.dart';
import 'package:myfarm/features/ambient_screen/domain/repositories/ambient_repository.dart';

class SaveAmbientSettings {
  final AmbientRepository repository;

  SaveAmbientSettings(this.repository);

  Future<void> call(
    AmbientSettings settings,
  ) {
    return repository.saveSettings(settings);
  }
}