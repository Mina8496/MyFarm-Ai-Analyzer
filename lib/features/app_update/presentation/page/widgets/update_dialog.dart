import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialog {
  static Future<void> show(
    BuildContext context, {
    required bool isForced,
    required String message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: !isForced,
      builder: (_) => PopScope(
        canPop: !isForced,
        child: AlertDialog(
          title: Text(isForced ? 'تحديث إجباري' : 'تحديث متاح'),
          content: Text(message),
          actions: [
            if (!isForced)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('لاحقًا'),
              ),
            ElevatedButton(
              onPressed: _openStore,
              child: const Text('تحديث الآن'),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _openStore() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final uri = Platform.isIOS
        ? Uri.parse('https://apps.apple.com/app/idYOUR_APPLE_ID') // TODO: حط الـ Apple ID الحقيقي
        : Uri.parse('https://play.google.com/store/apps/details?id=${packageInfo.packageName}');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}