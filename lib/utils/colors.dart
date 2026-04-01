import 'package:flutter/material.dart';

class AppColors {
  // Primary - Blue/Teal (MyChopBox theme)
  static const Color primary = Color(0xFF1565C0);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryBg = Color(0xFFE3F2FD);

  // Accent - Gold/Yellow
  static const Color accent = Color(0xFFFFB300);
  static const Color accentLight = Color(0xFFFFCA28);
  static const Color accentDark = Color(0xFFF57F17);

  // Teal
  static const Color teal = Color(0xFF00897B);
  static const Color tealLight = Color(0xFF4DB6AC);

  // Success / Error
  static const Color success = Color(0xFF43A047);
  static const Color error = Color(0xFFE53935);
  static const Color red50 = Color(0xFFFFEBEE);
  static const Color red600 = Color(0xFFE53935);

  // Gray palette
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // White
  static const Color white = Color(0xFFFFFFFF);

  // Gradient for headers
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
  );
}
