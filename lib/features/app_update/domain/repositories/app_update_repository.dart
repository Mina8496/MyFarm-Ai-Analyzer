import 'package:myfarm/features/app_update/domain/entities/app_version_settings.dart';

abstract class AppUpdateRepository {
  /// بترجع null لو مستند الإعدادات مش موجود
  Future<AppVersionSettings?> fetchVersionSettings();
}