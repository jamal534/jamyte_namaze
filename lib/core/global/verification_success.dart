import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';

import '../app_route/app_route.dart';


class VerificationSuccess extends StatelessWidget {
  const VerificationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.h,
      width: 360.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.sp),
        color: Color(0xFFFEFEFE),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            AssetPath.congressOtp,
            height: 157.h,
            width : 175.w,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextInter(
            textAlign: TextAlign.center,
              text: "Account  verified \nSuccessfully",
            fontWeight: FontWeight.w600,
            size: 20.sp,
            color: Color(0xFF20222C),
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
              width: 150.w,
              text: "Done",
              onPressed: () {
                Get.toNamed(AppRoute.loginScreen);
              })
        ],
      ),
    );
  }
}
