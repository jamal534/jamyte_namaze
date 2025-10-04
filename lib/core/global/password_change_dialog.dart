import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/app_route/app_route.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';


class PasswordChangeDialog extends StatelessWidget {
  const PasswordChangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410.h,
      width: 360.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.sp),
        color: Color(0xFFFEFEFE),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                  child: Icon(Icons.close)),
            ),
            Image.asset(
              AssetPath.passwordChangeDialog,
              height: 157.h,
              width : 175.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextInter(
              textAlign: TextAlign.center,
              text: "Password Changed",
              fontWeight: FontWeight.w600,
              size: 20.sp,
              color: Color(0xFF20222C),
            ),
            CustomTextInter(
              textAlign: TextAlign.center,
              text: "Password changed succesfully, you can login again with new password",
              fontWeight: FontWeight.w400,
              size: 16.sp,
              color: Color(0xFF718096),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
                text: "Log In",
                onPressed: () {
                  Get.toNamed(AppRoute.loginScreen);
                })
          ],
        ),
      ),
    );
  }
}
