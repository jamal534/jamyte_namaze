import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_route/app_route.dart';
import '../../../core/helper/shared_preference_helper.dart';

import '../../../core/service_class/network_caller/model/network_response.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/utils/app_urls.dart';


class SocialLogin extends GetxController {
  SharedPreferencesHelper prefs = SharedPreferencesHelper();
  RxBool isLoading = false.obs;

  Future<void> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      isLoading.value = true;
      var user = await googleSignIn.signIn();

      if (user != null) {
        final GoogleSignInAuthentication googleAuth = await user.authentication;
        String accessToken = googleAuth.accessToken ?? "No Access Token";
        if (accessToken.isNotEmpty) {
          Map<String, dynamic> userCredintial = {
            "username": user.displayName.toString(),
            "email": user.email.toString(),
          };

          ResponseData response =
          await NetworkCaller().postRequest(AppUrls.auth_login, body: userCredintial);

          if (response.isSuccess) {


            saveToken(response.responseData["accessToken"]);



            debugPrint('save token =======> ${accessToken}');
            debugPrint("Login Success");
            // await SharePrefsHelper.setString("userId", response.responseData['id']);
            Get.offAllNamed(AppRoute.navBar);
            debugPrint("Name: ${user.displayName}");
            debugPrint("Email: ${user.email}");
            debugPrint("Profile Photo: ${user.photoUrl}");
          }
        }
      }
    } catch (e) {
      debugPrint("Error during Google Sign-In: ${e.toString()}");
    }
    finally {
      isLoading.value = false;
    }
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', token);
  }
}


