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

  static const Gradient backgroundDark = LinearGradient(
    colors: [
      AppColors.primary, // merah tua
      Color.fromARGB(255, 110, 7, 31), // merah muda
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient header = LinearGradient(
    colors: [
      AppColors.secondary, // merah muda
      AppColors.fourth, // kuning
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );

  static const Gradient infoContainer = LinearGradient(
    colors: [
      AppColors.secondary, // merah muda
      AppColors.fourth, // kuning
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
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

  static const Gradient category = LinearGradient(
    colors: [AppColors.categoryHighlight, AppColors.category],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
