import 'package:cardify/core/const/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  dividerColor: AppColors.outlineLight,
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,       // warna kursor
      selectionColor: AppColors.primary.withOpacity(0.2), // warna highlight saat blok teks
      selectionHandleColor: AppColors.primary, // handle drag teks
    ),
);
