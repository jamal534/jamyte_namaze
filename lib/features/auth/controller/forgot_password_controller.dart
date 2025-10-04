import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jamayate_namaj/features/auth/presentation/screen/login_screen.dart';
import 'package:jamayate_namaj/features/auth/presentation/screen/reset_password_verify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_route/app_route.dart';
import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/service_class/network_caller/model/network_response.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/utils/app_urls.dart';


class ForgotPasswordController extends GetxController {

  TextEditingController forgotText = TextEditingController();
  TextEditingController forgotPhone = TextEditingController();
  TextEditingController pinput = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newConfirmPass = TextEditingController();

  RxBool isLoading = false.obs;

  String? validatePasswordMatch(String? value) {
    if (value != newPassword.value.text) return "Passwords do not match";
    return null;
  }

  Future<void> forgotPassword(String selectedMethod) async {
    Map<String, dynamic> body = {};

    if (selectedMethod == 'email') {
      body = {"identity": forgotText.text};
    } else if (selectedMethod == 'phone') {
      body = {"identity": forgotPhone.text};
    }

    try {
      isLoading.value = true;

      ResponseData response =
      await NetworkCaller().postRequest(AppUrls.send_otp, body: body);

      if (response.isSuccess) {
        Get.to(ResetPasswordVerify(selectedMethod: selectedMethod));
      } else {
        Get.snackbar("Error", "Failed to send OTP.");
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> ForgotPasswordVerify(String selectedMethod) async {
    String? otpString = pinput.text;

    Map<String, dynamic> otpBody = {
      "identity": selectedMethod == 'email' ? forgotText.text : forgotPhone.text,
      "otp": otpString,
    };

    try {
      isLoading.value = true;
      ResponseData response =
      await NetworkCaller().postRequest(AppUrls.verify_otp, body: otpBody);

      if (response.statusCode==200) {
        saveToken(response.responseData["accessToken"]);
        Get.toNamed(AppRoute.createNewPassword);
      } else {
        Get.snackbar("Error", "Failed to verify OTP. Please try again.");
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar("Error", "An error occurred while verifying the OTP.");
    } finally {
      isLoading.value = false;
    }
  }


  // Future<void> setNewPassword(BuildContext context) async {
  //   Map<String, dynamic> emailPass = {
  //     // "email": forgotText.text,
  //     "newPassword": newConfirmPass.text
  //   };
  //
  //   try {
  //     isLoading.value = true;
  //     final response = await NetworkCaller()
  //         .patchRequest(Utils.baseUrl + Utils.resetPassword, body: emailPass,
  //     );
  //
  //     if (response.isSuccess) {
  //         showDialog(
  //           barrierDismissible: false,
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               contentPadding: EdgeInsets.all(0.0),
  //               content: PasswordChangeDialog(),
  //             );
  //           },
  //         );
  //       }
  //   } catch (e) {
  //     debugPrint("======$e");
  //     isLoading.value = false;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }



  setNewPassword() async {


    Map<String, dynamic> body = {
      "newPassword": newConfirmPass.text,
    };

    try {
      isLoading.value = true;
      ResponseData response =
      await NetworkCaller().patchRequest(AppUrls.reset_pass, body: body);

      debugPrint("Request Body: $body");
      debugPrint("Response Code: ${response.statusCode}");


      if (response.statusCode == 200) {
        debugPrint("Password updated successfully!");
        Get.offAll(()=>LoginScreen());
      } else {
        Get.snackbar('Error', response.responseData.toString());
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
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
