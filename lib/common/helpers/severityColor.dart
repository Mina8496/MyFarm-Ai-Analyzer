import 'dart:ui';

import 'package:flutter/material.dart';

Color severityColor(int severity) {
  if (severity <= 1) return Colors.green;
  if (severity <= 3) return Colors.orange;
  return Colors.red;
}

String severityText(int severity) {
  if (severity <= 1) return 'Low severity';
  if (severity <= 3) return 'Medium severity';
  return 'High severity';
}
