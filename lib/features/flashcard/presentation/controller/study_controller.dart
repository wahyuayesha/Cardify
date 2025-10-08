import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class StudyController extends GetxController {
  var kartuAktif = 0.obs;

  void nextCard(int totalKartu) {
    if (kartuAktif < totalKartu - 1) {
      kartuAktif++;
    }
  }

  double getProgress(int totalKartu) {
    return (kartuAktif.value + 1) / totalKartu;
  }
}
