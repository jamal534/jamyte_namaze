import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';


class VerificationFaield extends StatelessWidget {
  const VerificationFaield({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.sp),
        color: Color(0xFFFEFEFE),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            AssetPath.verification_faield,
            height: 157.h,
            width : 175.w,
          ),
          CustomTextInter(
            textAlign: TextAlign.center,
            text: "Account  verified Failed",
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
                Get.back();
                // Get.toNamed(AppRoute.signInScreen);
              })
        ],
      ),
    );
  }
}
