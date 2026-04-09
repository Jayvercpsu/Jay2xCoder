import 'package:flutter/material.dart';

class AppTheme {
  static const Color _lightPrimary = Color(0xFF6C7FE8);
  static const Color _lightSecondary = Color(0xFF66C8C0);
  static const Color _lightBackground = Color(0xFFEFF4FF);

  static const Color _darkPrimary = Color(0xFF8EA2FF);
  static const Color _darkSecondary = Color(0xFF6EDCD3);
  static const Color _darkBackground = Color(0xFF0D1426);

  static ThemeData light() {
    final ColorScheme scheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: _lightPrimary,
      primary: _lightPrimary,
      secondary: _lightSecondary,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _lightBackground,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: _textTheme(ThemeData.light().textTheme, scheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF1E2534),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        shadowColor: Colors.black.withValues(alpha: 0.08),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF7F9FF),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD8E2F6)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD8E2F6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _lightPrimary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(46),
          backgroundColor: _lightPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(46),
          side: const BorderSide(color: _lightPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      navigationBarTheme: _navigationBarTheme(scheme, Brightness.light),
    );
  }

  static ThemeData dark() {
    final ColorScheme scheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _darkPrimary,
      primary: _darkPrimary,
      secondary: _darkSecondary,
      surface: const Color(0xFF121B31),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _darkBackground,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: _textTheme(ThemeData.dark().textTheme, scheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF121B31),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      navigationBarTheme: _navigationBarTheme(scheme, Brightness.dark),
    );
  }

  static TextTheme _textTheme(TextTheme base, ColorScheme scheme) {
    return base
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface)
        .copyWith(
          headlineSmall: base.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
          titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          bodyMedium: base.bodyMedium?.copyWith(height: 1.35),
        );
  }

  static NavigationBarThemeData _navigationBarTheme(
    ColorScheme scheme,
    Brightness brightness,
  ) {
    return NavigationBarThemeData(
      indicatorColor: scheme.primary.withValues(
        alpha: brightness == Brightness.dark ? 0.22 : 0.16,
      ),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
        Set<WidgetState> states,
      ) {
        final bool selected = states.contains(WidgetState.selected);
        return TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          fontSize: 11,
          color: selected
              ? scheme.onSurface
              : scheme.onSurface.withValues(alpha: 0.7),
        );
      }),
      elevation: 0,
      height: 66,
      backgroundColor: Colors.transparent,
    );
  }
}
