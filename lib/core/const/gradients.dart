import 'package:cardify/core/const/colors.dart';
import 'package:flutter/material.dart';

class AppGradients {
  static const Gradient splash = LinearGradient(
    colors: [AppColors.primary, AppColors.secondary, AppColors.fourth],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );

  static const Gradient background = LinearGradient(
    colors: [
      AppColors.primary, // merah tua
      AppColors.secondary, // merah muda
      AppColors.fourth, // kuning
    ],
    stops: [0.0, 0.23, 0.98],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Gradient header = LinearGradient(
    colors: [
      AppColors.secondary, // merah muda
      AppColors.fourth, // kuning
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );

  // Buttons
  static const Gradient primaryButton = LinearGradient(
    colors: [AppColors.primary, AppColors.tertiary],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  
  static const Gradient maroonButton = LinearGradient(
    colors: [AppColors.secondary, AppColors.primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient yellowButton = LinearGradient(
    colors: [AppColors.fourth, AppColors.tertiary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient flashcardButton = LinearGradient(
    colors: [AppColors.tertiary, AppColors.secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
