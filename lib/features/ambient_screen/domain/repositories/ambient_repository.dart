import '../entities/ambient_settings.dart';

abstract class AmbientRepository {
  Future<AmbientSettings> getSettings();

  Future<void> saveSettings(
    AmbientSettings settings,
  );

  Future<void> closeScreen();
}