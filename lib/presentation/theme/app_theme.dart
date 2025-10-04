import 'package:flutter/material.dart';
import 'package:minesweeper/presentation/theme/app_colors.dart';

class AppTheme {
  const AppTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4e5c92),
      surfaceTint: Color(0xff4e5c92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdce1ff),
      onPrimaryContainer: Color(0xff364479),
      secondary: Color(0xff595d72),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdee1f9),
      onSecondaryContainer: Color(0xff424659),
      tertiary: Color(0xff75546f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd7f5),
      onTertiaryContainer: Color(0xff5c3d57),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff1a1b21),
      onSurfaceVariant: Color(0xff45464f),
      outline: Color(0xff767680),
      outlineVariant: Color(0xffc6c5d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffb7c4ff),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff05164b),
      primaryFixedDim: Color(0xffb7c4ff),
      onPrimaryFixedVariant: Color(0xff364479),
      secondaryFixed: Color(0xffdee1f9),
      onSecondaryFixed: Color(0xff161b2c),
      secondaryFixedDim: Color(0xffc2c5dd),
      onSecondaryFixedVariant: Color(0xff424659),
      tertiaryFixed: Color(0xffffd7f5),
      onTertiaryFixed: Color(0xff2c1229),
      tertiaryFixedDim: Color(0xffe3bada),
      onTertiaryFixedVariant: Color(0xff5c3d57),
      surfaceDim: Color(0xffdbd9e0),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f2fa),
      surfaceContainer: Color(0xffefedf4),
      surfaceContainerHigh: Color(0xffe9e7ef),
      surfaceContainerHighest: Color(0xffe3e1e9),
    );
  }

  ThemeData light() {
    return theme(
      lightScheme(),
      extensions: [
        AppColors(
          borderHighlight: const Color(0xFFFFFFFF),
          borderShadow: const Color(0xFF808080),
          background: const Color(0xFFC6C6C6),
          negative: const Color(0xFFFF0000),
          colorOne: const Color(0xFF0000F7),
          colorTwo: const Color(0xFF017701),
          colorThree: const Color(0xFFEC0100),
          colorFour: const Color(0xFF000080),
          colorFive: const Color(0xFF800001),
          colorSix: const Color(0xFF008080),
          colorSeven: const Color(0xFF000000),
          colorEight: const Color(0xFF808080),
        ),
      ],
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb7c4ff),
      surfaceTint: Color(0xffb7c4ff),
      onPrimary: Color(0xff1e2d61),
      primaryContainer: Color(0xff364479),
      onPrimaryContainer: Color(0xffdce1ff),
      secondary: Color(0xffc2c5dd),
      onSecondary: Color(0xff2b3042),
      secondaryContainer: Color(0xff424659),
      onSecondaryContainer: Color(0xffdee1f9),
      tertiary: Color(0xffe3bada),
      onTertiary: Color(0xff43273f),
      tertiaryContainer: Color(0xff5c3d57),
      onTertiaryContainer: Color(0xffffd7f5),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff121318),
      onSurface: Color(0xffe3e1e9),
      onSurfaceVariant: Color(0xffc6c5d0),
      outline: Color(0xff90909a),
      outlineVariant: Color(0xff45464f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e1e9),
      inversePrimary: Color(0xff4e5c92),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff05164b),
      primaryFixedDim: Color(0xffb7c4ff),
      onPrimaryFixedVariant: Color(0xff364479),
      secondaryFixed: Color(0xffdee1f9),
      onSecondaryFixed: Color(0xff161b2c),
      secondaryFixedDim: Color(0xffc2c5dd),
      onSecondaryFixedVariant: Color(0xff424659),
      tertiaryFixed: Color(0xffffd7f5),
      onTertiaryFixed: Color(0xff2c1229),
      tertiaryFixedDim: Color(0xffe3bada),
      onTertiaryFixedVariant: Color(0xff5c3d57),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff38393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1a1b21),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff292a2f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData dark() {
    return theme(
      darkScheme(),
      extensions: [
        AppColors(
          borderHighlight: const Color(0xFF788088),
          borderShadow: const Color(0xFF1E262E),
          background: const Color(0xFF464E56),
          negative: const Color(0xFFEE6766),
          colorOne: const Color(0xFF7CC7FF),
          colorTwo: const Color(0xFF66C266),
          colorThree: const Color(0xFFFF7788),
          colorFour: const Color(0xFFEE88FF),
          colorFive: const Color(0xFFDDAA22),
          colorSix: const Color(0xFF65CCCC),
          colorSeven: const Color(0xFF999999),
          colorEight: const Color(0xFFBDBDBD),
        ),
      ],
    );
  }

  ThemeData theme(
    ColorScheme colorScheme, {
    Iterable<ThemeExtension<AppColors>>? extensions,
  }) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: const TextTheme().apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    extensions: extensions,
  );
}
