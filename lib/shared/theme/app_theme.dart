import 'package:flutter/material.dart';
import '../constants/colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.accent,
    error: AppColors.error,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
);
