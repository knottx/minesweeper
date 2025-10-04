import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color borderHighlight;
  final Color borderShadow;
  final Color background;
  final Color negative;
  final Color colorOne;
  final Color colorTwo;
  final Color colorThree;
  final Color colorFour;
  final Color colorFive;
  final Color colorSix;
  final Color colorSeven;
  final Color colorEight;

  AppColors({
    required this.borderHighlight,
    required this.borderShadow,
    required this.background,
    required this.negative,
    required this.colorOne,
    required this.colorTwo,
    required this.colorThree,
    required this.colorFour,
    required this.colorFive,
    required this.colorSix,
    required this.colorSeven,
    required this.colorEight,
  });

  @override
  AppColors copyWith({
    Color? borderHighlight,
    Color? borderShadow,
    Color? background,
    Color? negative,
    Color? colorOne,
    Color? colorTwo,
    Color? colorThree,
    Color? colorFour,
    Color? colorFive,
    Color? colorSix,
    Color? colorSeven,
    Color? colorEight,
  }) {
    return AppColors(
      borderHighlight: borderHighlight ?? this.borderHighlight,
      borderShadow: borderShadow ?? this.borderShadow,
      background: background ?? this.background,
      negative: negative ?? this.negative,
      colorOne: colorOne ?? this.colorOne,
      colorTwo: colorTwo ?? this.colorTwo,
      colorThree: colorThree ?? this.colorThree,
      colorFour: colorFour ?? this.colorFour,
      colorFive: colorFive ?? this.colorFive,
      colorSix: colorSix ?? this.colorSix,
      colorSeven: colorSeven ?? this.colorSeven,
      colorEight: colorEight ?? this.colorEight,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      borderHighlight: Color.lerp(borderHighlight, other.borderHighlight, t)!,
      borderShadow: Color.lerp(borderShadow, other.borderShadow, t)!,
      background: Color.lerp(background, other.background, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
      colorOne: Color.lerp(colorOne, other.colorOne, t)!,
      colorTwo: Color.lerp(colorTwo, other.colorTwo, t)!,
      colorThree: Color.lerp(colorThree, other.colorThree, t)!,
      colorFour: Color.lerp(colorFour, other.colorFour, t)!,
      colorFive: Color.lerp(colorFive, other.colorFive, t)!,
      colorSix: Color.lerp(colorSix, other.colorSix, t)!,
      colorSeven: Color.lerp(colorSeven, other.colorSeven, t)!,
      colorEight: Color.lerp(colorEight, other.colorEight, t)!,
    );
  }
}
