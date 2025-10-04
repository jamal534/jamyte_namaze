import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/service_class/network_caller/repository/network_caller.dart';
import 'package:jamayate_namaj/core/utils/app_urls.dart';



class ComplaintController extends GetxController {
  TextEditingController description = TextEditingController();


  var selectedFile = "".obs;
var filess;

RxBool isLoading=false.obs;

  Future<void> pickVideoFromStorage() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path!;
      final file = File(filePath);

      if (file.path.endsWith('.mp4') || file.path.endsWith('.mkv')||file.path.endsWith('.jpg')||file.path.endsWith('.jpeg')||file.path.endsWith('.png')||file.path.endsWith('.svg') ) {
        selectedFile.value = file.path;
        filess=File(filePath);
      } else {
        Get.snackbar(
          'Invalid File',
          'Please select a valid video or Photo.',
        );
      }
    } else {
      Get.snackbar('No File Selected', 'Please select a video file.');
    }
  }





  Future<void> submitComplaint(String complaintType, String description) async {
isLoading.value=true;
try{
  Map<String, dynamic> requestBody = {"complaintType": complaintType, "description": description};

  final  response= await NetworkCaller().putFormDataWithImage("POST",AppUrls.complaint,requestBody,filess,"bodyData",imageName: "complaintFiles");

  if (response['success'] == true) {
    Get.back();
    Get.snackbar(
      "Success",
      "Complaint successfully",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );

  } else {
    String errorMessage = response['message'] ?? 'Unknown error';
    Get.snackbar(
      "Error",
      "Failed to add reservation: $errorMessage",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
}catch(e){
  debugPrint("$e");
}
finally{
  isLoading.value=false;
}


  }


  @override
  void onClose() {

    description.dispose();

    super.onClose();
  }
}
