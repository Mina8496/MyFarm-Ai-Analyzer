import '../../domain/entities/ambient_settings.dart';

class AmbientSettingsModel extends AmbientSettings {
  const AmbientSettingsModel({
    super.showClock,
    super.showDate,
    super.showWeather,
    super.showLocation,
    super.showMyFarm,
    super.timeout,
  });

  factory AmbientSettingsModel.fromEntity(
    AmbientSettings entity,
  ) {
    return AmbientSettingsModel(
      showClock: entity.showClock,
      showDate: entity.showDate,
      showWeather: entity.showWeather,
      showLocation: entity.showLocation,
      showMyFarm: entity.showMyFarm,
      timeout: entity.timeout,
    );
  }
}