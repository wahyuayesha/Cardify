
import 'package:get/get.dart';

class NavbarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void setOnItemTaped(int index) {
    selectedIndex.value = index;
  }
}
