import 'package:get/get.dart';

class NavController extends GetxController {
  RxInt currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}