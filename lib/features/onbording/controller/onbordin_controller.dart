import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaseviewController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController(initialPage: 0);

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
