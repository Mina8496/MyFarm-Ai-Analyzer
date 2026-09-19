import 'package:flutter/material.dart';

/// لون ثابت لكل اسم (زي واتساب لما مفيش صورة بروفايل).
class AvatarColor {
  AvatarColor._();

  static const List<Color> _palette = [
    Color(0xFFE57373),
    Color(0xFF64B5F6),
    Color(0xFF81C784),
    Color(0xFFFFB74D),
    Color.fromARGB(255, 194, 135, 205),
    Color(0xFF4DB6AC),
    Color(0xFFF06292),
    Color(0xFF9575CD),
    Color(0xFFA1887F),
  ];

  static Color forName(String name) {
    if (name.isEmpty) return _palette.first;
    return _palette[name.hashCode.abs() % _palette.length];
  }
}