import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';

class SocialContainer extends StatelessWidget {

  final String imagePath;
  final String text;

  const SocialContainer({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          width: 1.w,
          color: Color(0xFFDFE1E7),
        ),
      ),child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath,width: 24.w,height: 24.h,),
          SizedBox(width: 10.h,),
          CustomTextInter(
              text: text,
            fontWeight: FontWeight.w600,
            size: 14.sp,
            color: Color(0xFF20222C),
          )
        ],
            ),
      ),
    );
  }
}
