import 'package:myfarm/features/ambient_screen/data/datasources/ambient_settings_service.dart';
import '../models/ambient_settings_model.dart';

class AmbientLocalDataSource {
  Future<AmbientSettingsModel> getSettings() async {
    final showClock =
        await AmbientSettingsService.showClock();

    final showDate =
        await AmbientSettingsService.showDate();

    final showWeather =
        await AmbientSettingsService.showWeather();

    final showLocation =
        await AmbientSettingsService.showLocation();

    final showMyFarm =
        await AmbientSettingsService.showMyFarm();

    final timeout =
        await AmbientSettingsService.getTimeout();

    return AmbientSettingsModel(
      showClock: showClock,
      showDate: showDate,
      showWeather: showWeather,
      showLocation: showLocation,
      showMyFarm: showMyFarm,
      timeout: timeout,
    );
  }

  Future<void> saveSettings(
    AmbientSettingsModel settings,
  ) async {
    // هنا نضيف methods الحفظ الموجودة
    // في AmbientSettingsService الحالي.
  }
}