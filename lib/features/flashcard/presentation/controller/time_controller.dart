// Controller pemicu agar widget dibuild ulang setiap 1 mnit

import 'dart:async';

import 'package:get/get.dart';

class TimeController extends GetxController {
  var now = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(minutes: 1), (timer) {
      now.value = DateTime.now();
    });
  }
}
