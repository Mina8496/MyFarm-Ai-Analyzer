import 'package:flutter/services.dart';

class AmbientScreenService {
  static const MethodChannel _channel = MethodChannel('myfarm_ambient');

  /// يفتح شاشة الـ Ambient يدويًا (زرار "Open Ambient Screen")
  static Future<void> open() async {
    try {
      await _channel.invokeMethod('openAmbient');
    } on PlatformException catch (e) {
      throw Exception('Failed to open Ambient Screen: ${e.message}');
    }
  }

  /// يقفل شاشة الـ Ambient الحالية
  static Future<void> close() async {
    try {
      await _channel.invokeMethod('closeAmbient');
    } on PlatformException catch (e) {
      throw Exception('Failed to close Ambient Screen: ${e.message}');
    }
  }

  /// يشغّل الـ Service اللي بيراقب فتح الشاشة تلقائيًا
  static Future<void> startService() async {
    await _channel.invokeMethod('startAmbientService');
  }

  /// يوقف الـ Service
  static Future<void> stopService() async {
    await _channel.invokeMethod('stopAmbientService');
  }

  static Future<bool> hasOverlayPermission() async {
    try {
      return await _channel.invokeMethod<bool>('hasOverlayPermission') ?? false;
    } on PlatformException {
      return false;
    }
  }

  static Future<void> requestOverlayPermission() async {
    try {
      await _channel.invokeMethod('requestOverlayPermission');
    } catch (_) {}
  }
}