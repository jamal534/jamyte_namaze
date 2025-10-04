
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jamayate_namaj/core/service_class/network_caller/model/network_response.dart';
import 'package:jamayate_namaj/core/service_class/network_caller/repository/network_caller.dart';
import 'package:jamayate_namaj/features/profile/presentation/screen/profile_screen.dart';

import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/utils/app_urls.dart';

class EditeProfleController extends GetxController {
  TextEditingController usernameText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController phoneNoText = TextEditingController();

  RxBool isLoading = false.obs;

  Rxn<File> selectedImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    loadSelectedImage();
  }



  void loadSelectedImage() async {
SharedPreferencesHelper pref=await SharedPreferencesHelper();

    String? savedImagePath = await pref.getString('profileSelectedImagePath');
    if (savedImagePath!.isNotEmpty) {
      selectedImage.value = File(savedImagePath);
    }
  }

  Future<void> pickImage() async {
SharedPreferencesHelper pref=await SharedPreferencesHelper();

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await pref.setString('profileSelectedImagePath', pickedFile.path);
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> updateProfile() async {
    Map<String, dynamic> requestBody = {
      "username": usernameText.text,
      "phoneNo": phoneNoText.text,
      "password": passwordText.text,
    };


    String? imagePath = selectedImage.value?.path;



    try {
      isLoading.value = true;
      final  response= await NetworkCaller().putFormDataWithImage("PATCH",AppUrls.profile,requestBody,selectedImage.value!,"bodyData",imageName: "profileImage");

      if (response['success'] == true) {
        Get.back();
        Get.snackbar(
          "Success",
          "Profile update successfylly",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

      } else {
        String errorMessage = response['message'] ?? 'Unknown error';
        Get.snackbar(
          "Error",
          "Failed to update Profile: $errorMessage",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      log('Error updating profile: $e');
      Get.snackbar('Error', 'Failed to update profile. Please try again.',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
    finally {
      isLoading.value = false;
    }
  }

  Future<void> sendPutRequestWithHeadersAndImages(
      String url,
      Map<String, dynamic> body,
      String? imagePath,
      String? token,
      ) async {
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Token is invalid or expired.',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers.addAll({
        'Authorization': token,
      });

      request.fields['body'] = jsonEncode(body);

      if (imagePath != null && imagePath.isNotEmpty) {
        log('Attaching image: $imagePath');
        request.files.add(await http.MultipartFile.fromPath(
          'profileImage',
          imagePath,
        ));
      } else {
        log('No image selected');
      }
      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        debugPrint('====Success: ${response.body}');
        Get.snackbar("Success", "Profile updated Successfully");
        Get.to(ProfileScreen());
      } else {
        debugPrint('====Error: ${response.statusCode}, ${response.body}');
      }

    } catch (e) {
      log('Request error: $e');
      Get.snackbar('Error', 'Failed to update profile. Please try again.',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
    finally {
      isLoading.value = false;
    }
  }
}
