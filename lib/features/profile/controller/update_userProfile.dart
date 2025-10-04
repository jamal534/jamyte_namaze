// import 'package:flutter/cupertino.dart';
//
// Future<void> updateUserProfile() async {
//   await preferencesHelper.init();
//   var token = preferencesHelper.getString("userToken");
//   if (token != null) {
//     try {
//       isLoading.value = true;
//       final url = Uri.parse('${Utils.baseUrl}${Utils.updateProfile}');
//
//       Map<String, dynamic> inputProfileData = {
//         "userName": userNameTEController.text.trim(),
//         "email": emailTEController.text.trim(),
//       };
//
//       debugPrint("============$url");
//       var request = http.MultipartRequest('PATCH', url);
//       request.headers.addAll({
//         'Authorization': "${preferencesHelper.getString('userToken')}",
//       });
//       request.fields['bodyData'] = jsonEncode(inputProfileData);
//
//       if (selectedImage.value != null) {
//         final file = selectedImage.value!;
//         logger.i("Selected Image : ${selectedImage.value}");
//
//         String mimeType = 'image/jpeg';
//         if (file.path.endsWith('.png')) {
//           mimeType = 'image/png';
//         } else if (file.path.endsWith('.gif')) {
//           mimeType = 'image/gif';
//         } else if (file.path.endsWith('.bmp')) {
//           mimeType = 'image/bmp';
//         }
//
//         request.files.add(await http.MultipartFile.fromPath(
//           'profileImage',
//           file.path,
//           contentType: MediaType.parse(mimeType),
//         ));
//       }
//
//       var streamedResponse = await request.send();
//
//       var response = await http.Response.fromStream(streamedResponse);
//
//       if (response.statusCode == 200) {
//         debugPrint('====Success: ${response.body}');
//         Get.snackbar("Success", "Profile updated Successfully");
//         await Get.find<UserProfileController>().fetchUserProfile();
//       } else {
//         debugPrint('====Error: ${response.statusCode}, ${response.body}');
//       }
//     } catch (e) {
//       isLoading.value = false;
//       debugPrint('====An error occurred: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }