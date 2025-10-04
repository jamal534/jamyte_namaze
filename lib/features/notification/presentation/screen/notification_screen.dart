import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import '../../../../core/utils/asset_path.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // RxBool isNew = false.obs;

    final List<Map<String, String>> notifications = [
      {
        "image": AssetPath.notificationProfile,
        "title": "No Jamaat Found Nearby",
        "subtitle": "No one is available within 100 meters at this time.",
      },
      {
        "image": AssetPath.notificationProfile,
        "title": "Prayer Time Changed",
        "subtitle": "No one is available within 100 meters at this time.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: CustomTextInter(
          text: "Notification",
          color: Color(0xFF1A202C),
          fontWeight: FontWeight.w600,
          size: 18.sp,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final item = notifications[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Color(0xFFEBEEF2),
                    width: 2.w,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        item["image"]!,
                        height: 40.h,
                        width: 40.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextInter(
                              text: item["title"]!,
                              fontWeight: FontWeight.w600,
                              size: 16.sp,
                              color: Color(0xFF09101D),
                            ),
                            SizedBox(height: 5.h),
                            CustomTextInter(
                              text: item["subtitle"]!,
                              fontWeight: FontWeight.w400,
                              size: 12.sp,
                              color: Color(0xFF718096),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
