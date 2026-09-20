import 'package:flutter/material.dart';

/// بترجّع true لو اليوزر أكّد تسجيل الخروج.
Future<bool> showLogoutConfirmDialog(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('تسجيل الخروج'),
      content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('إلغاء'),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text(
            'تسجيل الخروج',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
