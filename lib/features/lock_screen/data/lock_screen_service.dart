import 'package:flutter/services.dart';

class LockScreenService {
  static const MethodChannel _channel =
      MethodChannel('myfarm_lock_screen');

  static Future<bool> open() async {
    final result = await _channel.invokeMethod<bool>(
      'openLockScreen',
    );

    return result ?? false;
  }
}