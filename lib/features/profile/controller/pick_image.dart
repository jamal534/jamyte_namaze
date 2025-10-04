//
// Future<void> pickImageFromStorage() async {
//   final result = await FilePicker.platform.pickFiles(
//     type: FileType.image,
//     allowMultiple: false,
//   );
//   if (result != null && result.files.isNotEmpty) {
//     final filePath = result.files.single.path!;
//     final file = File(filePath);
//
//     if (file.path.endsWith('.jpg') ||
//         file.path.endsWith('.jpeg') ||
//         file.path.endsWith('.png') ||
//         file.path.endsWith('.gif') ||
//         file.path.endsWith('.bmp')) {
//       selectedImage.value = file;
//     } else {
//       logger.w('Invalid File, Please select a valid image file.');
//     }
//   }
// }
// }