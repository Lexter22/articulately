import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Duolingo-inspired color palette — vibrant, friendly, energetic
  static const Color colorBackground = Color(0xFFF7F7F7);
  static const Color colorSurface = Color(0xFFFFFFFF);
  static const Color colorPrimary = Color(0xFF58CC02);
  static const Color colorPrimaryDark = Color(0xFF46A302);
  static const Color colorYellow = Color(0xFFFFD900);
  static const Color colorYellowDark = Color(0xFFC9A800);
  static const Color colorCoral = Color(0xFFFF4B4B);
  static const Color colorCoralDark = Color(0xFFCC0000);
  static const Color colorBlue = Color(0xFF1CB0F6);
  static const Color colorBlueDark = Color(0xFF0A8FCC);
  static const Color colorSuccess = Color(0xFF58CC02);
  static const Color colorTextPrimary = Color(0xFF3C3C3C);
  static const Color colorTextSecondary = Color(0xFF777777);
  static const Color colorTextOnColor = Color(0xFFFFFFFF);
  static const Color colorBorder = Color(0xFFE5E5E5);

  // Spacing constants (base unit: 8dp)
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing48 = 48.0;

  static ThemeData light() {
    final base = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: colorBackground,
      colorScheme: const ColorScheme.light(
        surface: colorSurface,
        primary: colorPrimary,
        secondary: colorYellow,
        error: colorCoral,
        onPrimary: colorTextOnColor,
        onSurface: colorTextPrimary,
        onError: colorTextOnColor,
      ),
    );

    // Nunito — rounded, friendly, very close to Duolingo's typeface
    final nunito = GoogleFonts.nunitoTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: nunito.copyWith(
        displayLarge: nunito.displayLarge?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: colorTextPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: nunito.headlineMedium?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: colorTextPrimary,
        ),
        titleMedium: nunito.titleMedium?.copyWith(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: colorTextPrimary,
        ),
        bodyMedium: nunito.bodyMedium?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: colorTextSecondary,
        ),
        bodySmall: nunito.bodySmall?.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: colorTextSecondary,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: colorBorder, width: 2),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: colorBackground,
        foregroundColor: colorTextPrimary,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: colorTextPrimary, size: 24),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          foregroundColor: colorTextOnColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: GoogleFonts.nunito(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorTextPrimary,
        contentTextStyle: GoogleFonts.nunito(color: colorTextOnColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
