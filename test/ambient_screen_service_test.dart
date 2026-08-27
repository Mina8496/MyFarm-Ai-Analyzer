import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';


void main() {
  test('placeholder', () {
    expect(true, isTrue);
  });
}

// ambient_screen_service.dart

class AmbientScreenService {
  static const MethodChannel _channel = MethodChannel('myfarm_alarm');

  static Future<void> startService() async {
    await _channel.invokeMethod('startAmbientService');
  }

  static Future<void> stopService() async {
    await _channel.invokeMethod('stopAmbientService');
  }

  /// يقفل شاشة الـ Ambient (الـ LockScreenActivity) ويرجّع الشاشة
  /// اللي كانت تحتها (شاشة القفل الحقيقية أو أي تطبيق كان شغال)
  static Future<void> close() async {
    await SystemNavigator.pop();
  }
}