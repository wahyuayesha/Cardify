import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final selectedLocale = const Locale('en', 'US').obs;

  void gantiBahasa(Locale locale) {
    selectedLocale.value = locale;
    Get.updateLocale(locale);
  }

  List<Map<String, dynamic>> get daftarBahasa => [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Indonesia', 'locale': const Locale('id', 'ID')},
    {'name': '한국어', 'locale': const Locale('ko', 'KR')},
    {'name': 'Español', 'locale': const Locale('es', 'ES')},
    {'name': 'Русский', 'locale': const Locale('ru', 'RU')},
  ];
}
