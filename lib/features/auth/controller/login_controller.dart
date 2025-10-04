import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_route/app_route.dart';
import '../../../core/helper/select_language_sharedprefer.dart';
import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/service_class/network_caller/model/network_response.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/utils/app_urls.dart';


class LoginController extends GetxController {
  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();
  SharedPreferencesHelper prefs = SharedPreferencesHelper();
  RxBool isLoading = false.obs;


  RxBool isRememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkSavedCredentials();
  }


  checkSavedCredentials() async {

    final SharedPreferences sp = await SharedPreferences.getInstance();

    String? email = sp.getString('email');
    String? password = sp.getString('password');

    debugPrint('Saved Email: $email');
    debugPrint('Saved Password: $password');

    if (email != null && password != null) {
      emailText.text = email;
      passText.text = password;
      isRememberMe.value = true;

    }
  }


  logIn() async {
    Map<String, String> body = {
      "email": emailText.text.trim(),
      "password": passText.text.trim(),
    };

    try {
      isLoading.value = true;
      ResponseData response =
      await NetworkCaller().postRequest(AppUrls.loginUrl, body: body);


      if (response.statusCode == 200) {


        saveToken(response.responseData["accessToken"]);
        String token=response.responseData["accessToken"];
        final jwt = JWT.decode(token);
        String myUserId=jwt.payload['id'];
debugPrint("My user ID="+myUserId);


        final SharedPreferences sp = await SharedPreferences.getInstance();
sp.setString("myUserId", myUserId);

        if (isRememberMe.value) {
          final SharedPreferences sp = await SharedPreferences.getInstance();
          await sp.setString('email', emailText.text.trim());
          await sp.setString('password', passText.text.trim());
        }

    await sp.setString("login", "yes");

        String? login=await sp.getString("login");

        debugPrint("is login? "+login.toString());
        Get.offAllNamed(AppRoute.navBar);
        Get.snackbar(
          "Success",
          "Login Successful",
        );
      } else {
        Get.snackbar('Error', response.errorMessage.toString());
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
    finally {
      isLoading.value = false;
    }


  }


  /// ================================== User logOut <<<<<<<<<<<<<<<<<<<<<<<<<<<<<///

  //
  static Future<void> logoutUser() async {
    try {

      final SharedPreferences sp = await SharedPreferences.getInstance();
    //  await sp.remove(SharedPreferenceValue.token);
      await SharedPrefsHelper.setLocale('user_locale', Locale('en', 'US'));
      Get.updateLocale(Locale('en', 'US'));
      sp.setString("login", "no");
      Get.offAllNamed(AppRoute.loginScreen);

      debugPrint("User logged out successfully and language reset to English.");
    } catch (e) {
      debugPrint("Error during logout: $e");
    }
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', token);
    debugPrint("login token== ${prefs.getString('userToken')}");
  }
}
