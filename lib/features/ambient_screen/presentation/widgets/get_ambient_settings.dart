
import 'package:myfarm/features/ambient_screen/domain/entities/ambient_settings.dart';
import 'package:myfarm/features/ambient_screen/domain/repositories/ambient_repository.dart';

class GetAmbientSettings {
  final AmbientRepository repository;

  GetAmbientSettings(this.repository);

  Future<AmbientSettings> call() {
    return repository.getSettings();
  }
}