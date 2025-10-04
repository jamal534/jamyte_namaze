import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_text.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: CustomTextInter(
          text: 'policy'.tr,
          color: Color(0xFF20222C),
          fontWeight: FontWeight.w600,
          size: 20.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            CustomTextInter(
                text: 'policy'.tr,
              fontWeight: FontWeight.w600,
              size: 16.sp,
              color: Color(0xFF20222C),
            ),
            SizedBox(height: 20.h,),
            CustomTextInter(
              text: 'privacyTitle1'.tr,
              fontWeight: FontWeight.w400,
              size: 16.sp,
              color: Color(0xFF718096),
            ),
            SizedBox(height: 20.h,),
            CustomTextInter(
              text: '',
              fontWeight: FontWeight.w600,
              size: 16.sp,
              color: Color(0xFF20222C),
            ),
            SizedBox(height: 20.h,),
            CustomTextInter(
              text: 'privacyTitle1'.tr,
              fontWeight: FontWeight.w400,
              size: 16.sp,
              color: Color(0xFF718096),
            ),
            SizedBox(height: 20.h,),
            CustomTextInter(
              text: 'contactus'.tr,
              fontWeight: FontWeight.w600,
              size: 16.sp,
              color: Color(0xFF20222C),
            ),
            SizedBox(height: 20.h,),
            CustomTextInter(
              text: 'privacyTitle3'.tr,
              fontWeight: FontWeight.w400,
              size: 16.sp,
              color: Color(0xFF718096),
            ),
          ],
        ),
      ),
    );
  }
}
