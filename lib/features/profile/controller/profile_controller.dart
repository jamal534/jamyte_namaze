import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jamayate_namaj/core/service_class/network_caller/model/network_response.dart';
import 'package:jamayate_namaj/core/service_class/network_caller/repository/network_caller.dart';
import 'package:jamayate_namaj/core/utils/app_urls.dart';
import '../../../core/helper/shared_preference_helper.dart';

class UserProfileController extends GetxController {
  RxString username = ''.obs;
  RxString email = ''.obs;
  RxString profileImageUrl = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {

isLoading.value=true;
    try {

      ResponseData response=await NetworkCaller().getRequest(AppUrls.profile);

      if (response.statusCode == 200) {

        username.value = response.responseData['username'] ?? 'No username';
        email.value = response.responseData['email'] ?? 'No email';
        profileImageUrl.value = response.responseData['profileImage'] ?? '';

      } else {
        Get.snackbar("Error", "Failed to fetch profile data.");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "An error occurred while fetching data.");
    }

    finally{
      isLoading.value=false;
    }
  }

}
