import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // ── Brand ──────────────────────────────────────────────────────
  static const primary     = Color(0xFF1B4332); // deep forest green
  static const primaryLight= Color(0xFF2D6A4F);
  static const primaryDim  = Color(0xFF40916C);
  static const gold        = Color(0xFFD4A017); // Ethiopian gold
  static const goldLight   = Color(0xFFE9C46A);

  // ── Dark theme surfaces ────────────────────────────────────────
  static const darkBg      = Color(0xFF0F0F0F);
  static const darkSurface = Color(0xFF1A1A1A);
  static const darkCard    = Color(0xFF242424);
  static const darkBorder  = Color(0xFF2E2E2E);
  static const darkDivider = Color(0xFF262626);

  // ── Light theme surfaces ───────────────────────────────────────
  static const lightBg      = Color(0xFFF8F7F4);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard    = Color(0xFFFFFFFF);
  static const lightBorder  = Color(0xFFE8E4DC);
  static const lightDivider = Color(0xFFEEEBE4);

  // ── Text ───────────────────────────────────────────────────────
  static const darkTextPrimary   = Color(0xFFF5F5F5);
  static const darkTextSecondary = Color(0xFF9E9E9E);
  static const darkTextMuted     = Color(0xFF616161);

  static const lightTextPrimary   = Color(0xFF1A1A1A);
  static const lightTextSecondary = Color(0xFF6B6B6B);
  static const lightTextMuted     = Color(0xFFAAAAAA);

  // ── Semantic ───────────────────────────────────────────────────
  static const error   = Color(0xFFE53935);
  static const success = Color(0xFF2E7D32);
  static const info    = Color(0xFF1565C0);

  // ── Category ──────────────────────────────────────────────────
  static Color categoryColor(String cat) => switch (cat.toLowerCase()) {
    'culture' => const Color(0xFF6A1B9A),
    'woreda'  => const Color(0xFF0277BD),
    _         => const Color(0xFF2E7D32),
  };
}

class AppTheme {
  static TextTheme _textTheme(Color primary, Color secondary, Color muted) {
    return TextTheme(
      displayLarge:  GoogleFonts.playfairDisplay(color: primary, fontWeight: FontWeight.w700, fontSize: 32),
      displayMedium: GoogleFonts.playfairDisplay(color: primary, fontWeight: FontWeight.w700, fontSize: 26),
      displaySmall:  GoogleFonts.playfairDisplay(color: primary, fontWeight: FontWeight.w600, fontSize: 22),
      headlineMedium:GoogleFonts.playfairDisplay(color: primary, fontWeight: FontWeight.w600, fontSize: 20),
      titleLarge:    GoogleFonts.inter(color: primary,   fontWeight: FontWeight.w600, fontSize: 17),
      titleMedium:   GoogleFonts.inter(color: primary,   fontWeight: FontWeight.w600, fontSize: 15),
      titleSmall:    GoogleFonts.inter(color: secondary, fontWeight: FontWeight.w500, fontSize: 13),
      bodyLarge:     GoogleFonts.inter(color: primary,   fontWeight: FontWeight.w400, fontSize: 15, height: 1.6),
      bodyMedium:    GoogleFonts.inter(color: secondary, fontWeight: FontWeight.w400, fontSize: 13, height: 1.5),
      bodySmall:     GoogleFonts.inter(color: muted,     fontWeight: FontWeight.w400, fontSize: 12),
      labelLarge:    GoogleFonts.inter(color: primary,   fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: .2),
      labelSmall:    GoogleFonts.inter(color: muted,     fontWeight: FontWeight.w500, fontSize: 11, letterSpacing: .8),
    );
  }

  static ThemeData get light {
    const cs = ColorScheme.light(
      primary:   AppColors.primary,
      secondary: AppColors.gold,
      surface:   AppColors.lightSurface,
      error:     AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightTextPrimary,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.lightBg,
      textTheme: _textTheme(AppColors.lightTextPrimary, AppColors.lightTextSecondary, AppColors.lightTextMuted),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: AppColors.lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.lightBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.lightDivider, thickness: 1, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        hintStyle: GoogleFonts.inter(color: AppColors.lightTextMuted, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.lightBorder)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.lightBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primary),
      iconTheme: const IconThemeData(color: AppColors.lightTextSecondary, size: 22),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    );
  }

  static ThemeData get dark {
    const cs = ColorScheme.dark(
      primary:   AppColors.primaryDim,
      secondary: AppColors.goldLight,
      surface:   AppColors.darkSurface,
      error:     AppColors.error,
      onPrimary: Colors.white,
      onSecondary: AppColors.darkBg,
      onSurface: AppColors.darkTextPrimary,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.darkBg,
      textTheme: _textTheme(AppColors.darkTextPrimary, AppColors.darkTextSecondary, AppColors.darkTextMuted),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBg,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: AppColors.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.darkDivider, thickness: 1, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        hintStyle: GoogleFonts.inter(color: AppColors.darkTextMuted, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.darkBorder)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.darkBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryDim, width: 1.5)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primaryDim),
      iconTheme: const IconThemeData(color: AppColors.darkTextSecondary, size: 22),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDim,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    );
  }
}
