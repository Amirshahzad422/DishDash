import 'package:flutter/material.dart';

class AppColors {
  // Gourmet Crimson Red & Obsidian Palette
  static const Color primary = Color(0xFFE53935);
  static const Color primaryDark = Color(0xFFC62828);
  static const Color primaryLight = Color(0xFFFFEBEE);
  static const Color primaryContainer = Color(0xFFFFCDD2);

  // Secondary Palette (Obsidian Onyx)
  static const Color secondary = Color(0xFF161622);
  static const Color secondaryLight = Color(0xFF252538);
  static const Color secondaryContainer = Color(0xFF32324A);

  // Surface & Background
  static const Color background = Color(0xFFF8F9FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F3F9);
  static const Color surfaceSubtle = Color(0xFFFFF0F0);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textLight = Color(0xFF94A3B8);

  // Functional & Accents
  static const Color success = Color(0xFF10B981);
  static const Color starYellow = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);

  // Luxury Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFE53935), Color(0xFFC62828)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Premium Soft Shadows
  static const BoxShadow softShadow = BoxShadow(
    color: Color(0x0C0F172A),
    blurRadius: 20,
    spreadRadius: -2,
    offset: Offset(0, 8),
  );

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x0A0F172A),
    blurRadius: 16,
    spreadRadius: -2,
    offset: Offset(0, 6),
  );

  static const BoxShadow primaryGlow = BoxShadow(
    color: Color(0x3AE53935),
    blurRadius: 16,
    offset: Offset(0, 6),
  );

  static const BoxShadow floatingShadow = BoxShadow(
    color: Color(0x1A0F172A),
    blurRadius: 30,
    spreadRadius: 0,
    offset: Offset(0, 12),
  );
}
