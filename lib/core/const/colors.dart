// ignore_for_file: deprecated_member_use

import 'package:flutter/widgets.dart';

class AppColors {
  // BASE
  static const Color baseLight = Color(0xFFFFFFFF);
  static const Color baseDark = Color(0xFF000000);

  // TEXT
  static Color subtitle = Color(0xFF000000).withOpacity(0.25);
  static Color subtitleLight = Color(0xFFFFFFFF).withOpacity(0.25);


  // BRAND
  static const Color primary = Color(0xFFB0183D);
  static const Color secondary = Color(0xFFE23C64);
  static const Color tertiary = Color(0xFFFF5E5E);
  static const Color fourth = Color(0xFFFFD464);
  static const Color fifth = Color(0xFFF46839);

  // CATEGORY / SPECIAL
  static const Color category = Color(0xFF6BBA86);

  // TRANSLUCENT
  static Color fillTrans = AppColors.baseLight.withOpacity(0.2);
  static Color borderTrans = AppColors.baseLight.withOpacity(0.1);

  // THEME SPECIFIC
  // light
  static const Color backgroundLight = baseLight;
  static const Color outlineLight = Color(0xFFF0F0F0);
  static const Color backgroundDark = Color(0xFF272433);
  static const Color outlineDark = Color(0xFF322E40);
}
