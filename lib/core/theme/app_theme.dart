import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color surface;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;

  const AppColors({
    required this.background,
    required this.surface,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
  });

  static const light = AppColors(
    background: ColorPalette.kPrimaryColor,
    surface: Colors.white,
    card: ColorPalette.kcardGreen,
    textPrimary: Colors.black,
    textSecondary: Color(0xFF6B8F6A),
    border: ColorPalette.kBorder,
  );

  static const dark = AppColors(
    background: Color(0xFF101810),
    surface: Color(0xFF1A241A),
    card: Color(0xFF243324),
    textPrimary: Colors.white,
    textSecondary: Color(0xFFAAAAAA),
    border: Color(0xFF3D5A3C),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? card,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
  }) => AppColors(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    card: card ?? this.card,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    border: border ?? this.border,
  );

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorPalette.kSecondaryGreen,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.light.background,
    extensions: const [AppColors.light],
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorPalette.kSecondaryGreen,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.dark.background,
    extensions: const [AppColors.dark],
  );
}