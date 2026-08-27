import 'package:flutter/material.dart';

/// نظام الألوان والمسافات الخاص بشاشة الـ Ambient.
/// كل الألوان مستوحاة من هوية المزرعة: أخضر الغابة، ذهبي الحصاد، أخضر النمو.
class AmbientTheme {
  AmbientTheme._();

  // الخلفية — أخضر غابة عميق جدًا، مش أسود خالص
  static const Color bgDeep = Color(0xFF07130C);
  static const Color bgGlow = Color(0xFF0D2116);

  // النصوص
  static const Color textPrimary = Color(0xFFF5F7F0);
  static const Color textSecondary = Color(0xFF9AB09E);
  static const Color textTertiary = Color(0xFF5C6D60);

  // الألوان المميزة
  static const Color accentGold = Color(0xFFE4AE55); // الشمس / الحصاد
  static const Color accentLeaf = Color(0xFF74C69D); // النمو / MyFarm

  static const Color hairline = Color(0x14F5F7F0); // خط فاصل رفيع جدًا

  static const double spaceXS = 6;
  static const double spaceS = 12;
  static const double spaceM = 20;
  static const double spaceL = 32;
  static const double spaceXL = 44;
}