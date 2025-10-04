import 'package:get/get.dart';

class SwitchController extends GetxController {
  var isSwitched = false.obs;

  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }
}

class ForgetController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void selectIndex(int index) {
    selectedIndex.value = index;
  }
}