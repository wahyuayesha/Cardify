import 'package:cardify/core/theme/dark_theme.dart';
import 'package:cardify/core/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  ThemeData get theme => isDark.value ? darkTheme : lightTheme;

  void switchTheme(bool value) {
    isDark.value = value;
  }
}
