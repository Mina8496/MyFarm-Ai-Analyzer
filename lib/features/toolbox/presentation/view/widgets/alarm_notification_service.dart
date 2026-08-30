import 'package:flutter/services.dart';

class AlarmNotificationService {
  static const MethodChannel _channel = MethodChannel('myfarm_alarm');

  Future<void> init() async {
    // أي تهيئة موجودة عندك أصلاً تفضل زي ما هي
  }

  /// يتأكد من إذن الـ exact alarm، ويطلبه من المستخدم لو مش ممنوح.
  /// يرجّع true لو الإذن ممنوح فعليًا (بعد الطلب أو كان ممنوح أصلاً).
  Future<bool> ensureExactAlarmPermission() async {
    final canSchedule = await _channel.invokeMethod<bool>('canScheduleExactAlarms') ?? false;

    if (canSchedule) return true;

    // يفتح شاشة إعدادات النظام "Alarms & reminders" للتطبيق
    await _channel.invokeMethod('requestExactAlarmPermission');

    // بعد رجوع المستخدم من الإعدادات، تحقق تاني
    return await _channel.invokeMethod<bool>('canScheduleExactAlarms') ?? false;
  }

  Future<void> scheduleDailyAlarm(DateTime time) async {
    final granted = await ensureExactAlarmPermission();

    if (!granted) {
      throw Exception('PERMISSION_DENIED');
    }

    await _channel.invokeMethod('scheduleAlarm', {
      'id': time.millisecondsSinceEpoch ~/ 60000, // أو أي منطق ID عندك أصلاً
      'timestamp': time.millisecondsSinceEpoch,
      'hour': time.hour,
      'minute': time.minute,
    });
  }

  Future<void> cancelAlarm(DateTime time) async {
    await _channel.invokeMethod('cancelAlarm', {
      'id': time.millisecondsSinceEpoch ~/ 60000,
    });
  }
}