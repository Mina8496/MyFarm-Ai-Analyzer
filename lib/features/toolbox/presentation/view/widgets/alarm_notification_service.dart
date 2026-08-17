import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class AlarmNotificationService {
  static const MethodChannel _channel = MethodChannel('myfarm_alarm');

  Future<void> init() async {
    tz_data.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
  }

  Future<void> scheduleDailyAlarm(DateTime time) async {
    final scheduled = _nextInstanceOfTime(time);

    final id = _idFromTime(time);

    await _channel.invokeMethod('scheduleAlarm', {
      'id': id,
      'timestamp': scheduled.millisecondsSinceEpoch,
      'hour': time.hour,
      'minute': time.minute,
    });
    await _channel.invokeMethod('requestIgnoreBatteryOptimization');
  }

  Future<void> cancelAlarm(DateTime time) async {
    final id = _idFromTime(time);

    await _channel.invokeMethod('cancelAlarm', {'id': id});
  }

  int _idFromTime(DateTime time) {
    return time.hour * 100 + time.minute;
  }

  tz.TZDateTime _nextInstanceOfTime(DateTime time) {
    final now = tz.TZDateTime.now(tz.local);

    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}
