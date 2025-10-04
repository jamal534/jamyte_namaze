import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/global/verification_faield.dart';
import '../../../core/app_route/app_route.dart';
import '../../../core/global/verification_success.dart';
import '../../../core/service_class/network_caller/model/network_response.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/utils/app_urls.dart';




class SignUpController extends GetxController {
  final emailText = TextEditingController();
  final passText = TextEditingController();
  final userName = TextEditingController();

  TextEditingController pinput = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> signUp() async {
    Map<String, dynamic> registration = {
      "username" : userName.text.trim(),
      "email": emailText.text.trim(),
      "password": passText.text.trim(),
    };

    try {
      isLoading.value = true;

      ResponseData response =
      await NetworkCaller().postRequest(AppUrls.registerUrl, body: registration);


      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint("${response.statusCode}");
        debugPrint("Sing Up Successful");
        Get.toNamed(AppRoute.singUPOtpScreen);
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }



  ///================================== Sing Up Verify ======================///

  Future<void> pinSubmit(BuildContext context) async {
    String? otpString;
    try {
      otpString = pinput.text;
      debugPrint("=====$otpString");
    } catch (e) {
      debugPrint("=====$e");
    }

    Map<String, dynamic> emailOtp = {"email": emailText.text, "otp": otpString};

    try {
      isLoading.value = true;
      ResponseData response =
      await NetworkCaller().postRequest(AppUrls.signup_verify_otp, body: emailOtp);

      if (response.isSuccess) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(0.0),
              content: VerificationSuccess(),
            );
          },
        );
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(0.0),
                content: VerificationFaield(),
              );
            },
          );
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar("Error", "An error occurred while verifying the PIN.");
    }
    finally {
      isLoading.value = false;
    }
  }


}
