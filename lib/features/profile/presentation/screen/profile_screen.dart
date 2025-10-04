// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:jamayate_namaj/core/global/custom_text.dart';
// import 'package:jamayate_namaj/core/global/logout_dialog.dart';
// import 'package:jamayate_namaj/core/utils/asset_path.dart';
// import 'package:jamayate_namaj/features/profile/controller/edite_profle_controller.dart';
// import 'package:jamayate_namaj/features/profile/controller/profile_controller.dart';
// import 'package:jamayate_namaj/features/profile/presentation/screen/complaint.dart';
// import 'package:jamayate_namaj/features/profile/presentation/screen/privacy_policy.dart';
// import 'package:jamayate_namaj/features/profile/presentation/screen/profile_details_screen.dart';
// import 'package:jamayate_namaj/features/profile/presentation/screen/select_language.dart';
//
//
// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({super.key});
//
//
// // final ProfileController profileController = Get.put(ProfileController());
//   final UserProfileController userProfileController = Get.put(UserProfileController());
//
//   final List<Map<String, dynamic>> proFile = [
//     {'image': AssetPath.profile, 'title': 'edit_profile'.tr, 'icon': Icons.arrow_forward_ios_rounded},
//     {'image': AssetPath.note_edite, 'title': 'complaint'.tr, 'icon': Icons.arrow_forward_ios_rounded},
//     {
//       'image': AssetPath.language,
//       'title': 'language'.tr,
//       'icon': Icons.arrow_forward_ios_rounded,
//     },
//     {
//       'image': AssetPath.privacyPolicy,
//       'title': 'policy'.tr,
//     },
//     {
//       'image': AssetPath.logout,
//       'title': 'logout'.tr,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         centerTitle: true,
//         title: CustomTextInter(
//             text: 'profile'.tr,
//           fontWeight: FontWeight.w600,
//           size: 20.sp,
//           color: Color(0xFF20222C),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           children: [
//             Image.asset(
//               AssetPath.userProfile,
//               height: 120.h,
//             ),
//             CustomTextInter(
//                 text: 'username'.tr,
//               fontWeight: FontWeight.w600,
//               size: 16.sp,
//               color: Color(0xFF20222C),
//             ),
//             CustomTextInter(
//               text: "rafiislam@mail.com",
//               fontWeight: FontWeight.w400,
//               size: 12.sp,
//               color: Color(0xFF718096),
//             ),
//             SizedBox(height: 20.h),
//             Divider(
//               thickness: 1.5,
//               height: 1.h,
//               color: Color(0xFFEDF2F7),
//             ),
//
//
//             // Obx(() {
//             //   if (userProfileController.isLoading.value) {
//             //     return CircularProgressIndicator();
//             //   } else {
//             //     return Column(
//             //       children: [
//             //         Image.asset(
//             //           AssetPath.userProfile,
//             //           height: 120.h,
//             //         ),
//             //         CustomTextInter(
//             //           text: userProfileController.username.value,
//             //           fontWeight: FontWeight.w600,
//             //           size: 16.sp,
//             //           color: Color(0xFF20222C),
//             //         ),
//             //         CustomTextInter(
//             //           text: userProfileController.email.value,
//             //           fontWeight: FontWeight.w400,
//             //           size: 12.sp,
//             //           color: Color(0xFF718096),
//             //         ),
//             //         SizedBox(height: 20.h),
//             //         Divider(
//             //           thickness: 1.5,
//             //           height: 1.h,
//             //           color: Color(0xFFEDF2F7),
//             //         ),
//             //       ],
//             //     );
//             //   }
//             // }),
//
//
//             Expanded(
//               child: ListView.separated(
//                 itemCount: proFile.length,
//                 itemBuilder: (context, index) {
//                   bool isLogout = proFile[index]['isLogout'] ?? false;
//                   return GestureDetector(
//                     onTap: () async {
//                       switch (index) {
//                         case 0:
//                         Get.to(() => ProfileDetailsScreen());
//                           break;
//                         case 1:
//                         Get.to(()=> ComplaintPage());
//                           break;
//                         case 2:
//                         Get.to(()=>SelectLanguage());
//                           break;
//                         case 3:
//                         Get.to(()=>PrivacyPolicy());
//                           break;
//                         case 4:
//                         showDialog(
//                           barrierDismissible: false,
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               contentPadding: EdgeInsets.all(0.0),
//                               content: LogoutDialog(),
//                             );
//                           },
//                         );
//                           break;
//                         default:
//                           break;
//                       }
//                     },
//                     child: ListTile(
//                       leading: Image.asset(
//                         proFile[index]['image'],
//                         height: 30.h,
//                       ),
//                       title: Text(
//                         proFile[index]['title'],
//                         style: GoogleFonts.inter(
//                           fontWeight: isLogout ? FontWeight.w500 : FontWeight.w400,
//                           fontSize: 16.sp,
//                           color: isLogout ? Colors.red : Color(0xFF2D2D2D),
//                         ),
//                       ),
//                       trailing: proFile[index]['icon'] != null ? Icon(proFile[index]['icon']) : SizedBox(),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return const Divider(
//                     // thickness: 0.0,
//                     color: Colors.white,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';
import 'package:jamayate_namaj/features/profile/presentation/screen/privacy_policy.dart';
import 'package:jamayate_namaj/features/profile/presentation/screen/profile_details_screen.dart';
import 'package:jamayate_namaj/features/profile/presentation/screen/select_language.dart';

import '../../../../core/global/logout_dialog.dart';
import '../../controller/profile_controller.dart';
import 'complaint.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserProfileController controller = Get.put(UserProfileController());

  final List<Map<String, dynamic>> proFile = [
    {'image': AssetPath.profile, 'title': 'edit_profile'.tr, 'icon': Icons.arrow_forward_ios_rounded},
    {'image': AssetPath.note_edite, 'title': 'complaint'.tr, 'icon': Icons.arrow_forward_ios_rounded},
    {'image': AssetPath.language, 'title': 'language'.tr, 'icon': Icons.arrow_forward_ios_rounded},
    {'image': AssetPath.privacyPolicy, 'title': 'policy'.tr},
    {'image': AssetPath.logout, 'title': 'logout'.tr},
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: CustomTextInter(
          text: 'profile'.tr,
          fontWeight: FontWeight.w600,
          size: 20.sp,
          color: Color(0xFF20222C),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            // Profile Image and Username, Email
            Obx(() {
                return controller.isLoading.value?Center(child: CircularProgressIndicator(),):
                  Column(
                  children: [
                    // Profile Image
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(controller.profileImageUrl.value.isNotEmpty
                          ? controller.profileImageUrl.value
                          : AssetPath.userProfile),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextInter(
                      text: controller.username.value.isNotEmpty
                          ? controller.username.value
                          : 'No username',
                      fontWeight: FontWeight.w600,
                      size: 16.sp,
                      color: Color(0xFF20222C),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextInter(
                      text: controller.email.value.isNotEmpty
                          ? controller.email.value
                          : 'No email',
                      fontWeight: FontWeight.w400,
                      size: 12.sp,
                      color: Color(0xFF718096),
                    ),
                    SizedBox(height: 20.h),
                    Divider(
                      thickness: 1.5,
                      height: 1.h,
                      color: Color(0xFFEDF2F7),
                    ),
                  ],
                );
            }
            ),

            // Profile Menu Items
            Expanded(
              child: ListView.separated(
                itemCount: proFile.length,
                itemBuilder: (context, index) {
                  bool isLogout = proFile[index]['isLogout'] ?? false;
                  return GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.to(() => ProfileDetailsScreen());
                          break;
                        case 1:
                          Get.to(() => ComplaintPage());
                          break;
                        case 2:
                          Get.to(() => SelectLanguage());
                          break;
                        case 3:
                          Get.to(() => PrivacyPolicy());
                          break;
                        case 4:
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(0.0),
                                content: LogoutDialog(),
                              );
                            },
                          );
                          break;
                        default:
                          break;
                      }
                    },
                    child: ListTile(
                      leading: Image.asset(
                        proFile[index]['image'],
                        height: 30.h,
                      ),
                      title: Text(
                        proFile[index]['title'],
                        style: GoogleFonts.inter(
                          fontWeight: isLogout ? FontWeight.w500 : FontWeight.w400,
                          fontSize: 16.sp,
                          color: isLogout ? Colors.red : Color(0xFF2D2D2D),
                        ),
                      ),
                      trailing: proFile[index]['icon'] != null
                          ? Icon(proFile[index]['icon'])
                          : SizedBox(),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.white,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
