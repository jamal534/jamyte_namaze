//
// import 'package:get/get.dart';
// import '../../../core/app_route/app_route.dart';
// import '../../../core/helper/shared_preference_helper.dart';
//
// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     navigate();
//   }
//
//   void navigate() async {
//
//     String? token = await SharePrefsHelper.getString(SharedPreferenceValue.token);
//
//     Future.delayed(const Duration(seconds: 3), () {
//       if (token != null) {
//         Get.offAllNamed(AppRoute.navBar);
//       } else {
//         Get.offAllNamed(AppRoute.onboardingScreen);
//       }
//     });
//   }
// }

//
// import 'package:get/get.dart';
//
// import '../../../core/app_route/app_route.dart';
//
//
// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     navigate();
//   }
//
//   void navigate() {
//     Future.delayed(const Duration(seconds: 3), () {
//       Get.offAllNamed(AppRoute.onboardingScreen);
//     });
//   }
// }
//
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_route/app_route.dart';
import '../../../core/helper/shared_preference_helper.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  void navigate() async {


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 3), () {
String? islogin=prefs.getString("login")??"no";

debugPrint("is login?="+islogin.toString());

      if (islogin==null  || islogin=="no") {
        Get.offAllNamed(AppRoute.onboardingScreen);
      } else {
  Get.offAllNamed(AppRoute.navBar);
      }
    });
  }
}
