import 'package:flutter/material.dart';
import 'package:minesweeper/presentation/theme/app_colors.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
