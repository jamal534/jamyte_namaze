import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamayate_namaj/features/onbording/presentation/screen/slide_model.dart';
import '../../../../core/global/custom_text.dart';

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          slidList[index].imageUrl,
          fit: BoxFit.cover,
          height: 440.h,
          width: double.infinity,
        ),

        Positioned(
          bottom: index == 0 ? 70.h : 0.h,
          left: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextInter(
                  text: slidList[index].title,
                  color: Color(0xFF20222C),
                  size: index == 1 ? 20.sp : 24.sp,
                  fontWeight:index == 1  ? FontWeight.w500 : FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                CustomTextInter(
                  text: slidList[index].description,
                  color: Color(0xFF718096),
                  size: 16.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
