import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/home_screen.dart';
import 'package:jamayate_namaj/features/profile/presentation/screen/profile_screen.dart';
import '../../../../core/utils/asset_path.dart';
import '../../../notification/presentation/screen/notification_screen.dart';
import '../../../Home_flow/screens/default_chat_screen.dart';
import '../../controller/navbar_controller.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (navController.currentIndex.value) {
          case 0:
            return HomeScreen();
          case 1:
            return DefaultChatScreen();
          case 2:
            return NotificationScreen();
          case 3:
            return  ProfileScreen();
          // case 4:
          //   return Profile();
          default:
            return Center(
              child: Text("Home"),
            );
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: navController.currentIndex.value,
          selectedFontSize: 12.sp,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF137058),
          unselectedFontSize: 12.sp,
          onTap: (index) {
            navController.updateIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(AssetPath.navHOme,
                  height: 24.w,
                  width: 24.w,
                  color: navController.currentIndex.value == 0
                      ? Color(0xFF137058)
                      : null),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AssetPath.groupChat,
                  height: 24.w,
                  width: 24.w,
                  color: navController.currentIndex.value == 1
                      ? Color(0xFF137058)
                      : null),
              label: 'groupChat'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AssetPath.notification,
                  height: 24.w,
                  width: 24.w,
                  color: navController.currentIndex.value == 2
                      ? Color(0xFF137058)
                      : null),
              label: 'notification'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AssetPath.navProfile,
                  height: 24.w,
                  width: 24.w,
                  color: navController.currentIndex.value == 3
                      ? Color(0xFF137058)
                      : null),
              label: 'profile'.tr,
            ),
            // BottomNavigationBarItem(
            //   icon: Image.asset(AssetPath.profile,
            //       height: 24.w,
            //       width: 24.w,
            //       color: navController.currentIndex.value == 4
            //           ? AppColor.primaryColor
            //           : null),
            //   label: "Profile",
            // ),
          ],
        );
      }),
    );
  }
}
