import 'package:flutter/material.dart';

class AppColors {
  // Gourmet Crimson Red & Obsidian Palette
  static const Color primary = Color(0xFFE53935);
  static const Color primaryDark = Color(0xFFC62828);
  static const Color primaryLight = Color(0xFFFFEBEE);
  static const Color primaryContainer = Color(0xFFFFCDD2);

  // Secondary Palette (Obsidian Charcoal)
  static const Color secondary = Color(0xFF1E1E28);
  static const Color secondaryLight = Color(0xFF2E2E3E);
  static const Color secondaryContainer = Color(0xFF3E3E52);

  // Surface & Background
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F7);
  static const Color surfaceSubtle = Color(0xFFFFF5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E1A17);
  static const Color textSecondary = Color(0xFF574E47);
  static const Color textLight = Color(0xFF9E9288);

  // Functional & Accents
  static const Color success = Color(0xFF10B981);
  static const Color starYellow = Color(0xFFFFB800);
  static const Color error = Color(0xFFD32F2F);
  static const Color border = Color(0xFFEEEEEE);
  static const Color divider = Color(0xFFF5F5F5);

  // Clean WebGL-Safe Shadows
  static const BoxShadow softShadow = BoxShadow(
    color: Color(0x0F000000),
    blurRadius: 12,
    offset: Offset(0, 4),
  );

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x08000000),
    blurRadius: 8,
    offset: Offset(0, 2),
  );

  static const BoxShadow primaryGlow = BoxShadow(
    color: Color(0x26E53935),
    blurRadius: 14,
    offset: Offset(0, 4),
  );
}
