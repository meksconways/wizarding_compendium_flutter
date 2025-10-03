import 'package:flutter/material.dart';
import '../navigation/slide_right_navigation.dart';
import 'hp_colors.dart';

class HpTheme {
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: HpColors.crimson,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFF8C2A2A),
    onPrimaryContainer: Colors.white,

    secondary: HpColors.gold,
    onSecondary: Colors.black,
    secondaryContainer: Color(0xFFE7CF7A),
    onSecondaryContainer: Color(0xFF3A2E00),

    tertiary: HpColors.brown,
    onTertiary: Color(0xFFEFE8DF),
    tertiaryContainer: Color(0xFF5B4734),
    onTertiaryContainer: Color(0xFFF6EFE7),

    error: Color(0xFFB3261E),
    onError: Colors.white,

    surface: HpColors.parchment,
    onSurface: HpColors.brown,

    surfaceContainerHighest: Color(0xFFE6E2D9),
    onSurfaceVariant: HpColors.brown,

    outline: HpColors.grey,
    shadow: Colors.black,
    scrim: Colors.black,

    inverseSurface: HpColors.brown,
    onInverseSurface: HpColors.parchment,
    inversePrimary: Color(0xFFE7B3B3),

    surfaceTint: HpColors.crimson,
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: HpColors.crimson,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFF4A1616),
    onPrimaryContainer: Color(0xFFFFEAEA),

    secondary: HpColors.gold,
    onSecondary: Color(0xFF201A00),
    secondaryContainer: Color(0xFF6B5713),
    onSecondaryContainer: Color(0xFFFFF3C0),

    tertiary: HpColors.brown,
    onTertiary: Color(0xFFF0E8DF),
    tertiaryContainer: Color(0xFF2D2319),
    onTertiaryContainer: Color(0xFFEADFD3),

    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),

    surface: HpColors.brown,
    onSurface: HpColors.parchment,

    surfaceContainerHighest: Color(0xFF2A2118),
    onSurfaceVariant: Color(0xFFD9D3CB),

    outline: Color(0xFF9DA2A6),
    shadow: Colors.black,
    scrim: Colors.black,

    inverseSurface: HpColors.parchment,
    onInverseSurface: HpColors.brown,
    inversePrimary: HpColors.gold,

    surfaceTint: HpColors.crimson,
  );

  // ---------- ThemeData ----------
  static ThemeData light() {
    final cs = lightScheme;
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      fontFamily: 'PTSans',
      scaffoldBackgroundColor: cs.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        titleLarge: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        titleMedium: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        displayLarge: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        displayMedium: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        displaySmall: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w400),
        headlineLarge: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        headlineMedium: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        headlineSmall: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w400),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: cs.surface,
        surfaceTintColor: cs.surfaceTint,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.secondary,
          foregroundColor: cs.onSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        labelStyle: TextStyle(color: cs.onSurfaceVariant),
      ),
      dividerTheme: DividerThemeData(color: cs.outline.withValues(alpha: .30), thickness: 1),
      listTileTheme: ListTileThemeData(
        iconColor: cs.onSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cs.inverseSurface,
        contentTextStyle: TextStyle(color: cs.onInverseSurface),
        actionTextColor: cs.inversePrimary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SlideRightTransitions(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData dark() {
    final cs = darkScheme;
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      fontFamily: 'PTSans',
      scaffoldBackgroundColor: cs.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        titleLarge: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        titleMedium: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        displayLarge: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        displayMedium: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        displaySmall: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w400),
        headlineLarge: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        headlineMedium: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w700),
        headlineSmall: const TextStyle(fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.w400),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: cs.surface,
        surfaceTintColor: cs.surfaceTint,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.onSurface,
          side: BorderSide(color: cs.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.secondary,
          foregroundColor: cs.onSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        labelStyle: TextStyle(color: cs.onSurfaceVariant),
      ),
      dividerTheme: DividerThemeData(color: cs.outline.withValues(alpha: .35), thickness: 1),
      listTileTheme: ListTileThemeData(
        iconColor: cs.onSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cs.inverseSurface,
        contentTextStyle: TextStyle(color: cs.onInverseSurface),
        actionTextColor: cs.inversePrimary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SlideRightTransitions(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}