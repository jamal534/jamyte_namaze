import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.width,
    this.borderRadius,
    this.textColor,
    this.fontWeight,
    this.height,
    this.fontSize,
  });

  final String text;
  final void Function() onPressed;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      // height: height ?? ,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor ?? Color(0xFF137058),
          padding: EdgeInsets.symmetric(vertical: height?.h ?? 18.h),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: textColor ?? Color(0xFFFFFFFF),
            fontSize: fontSize ?? 16.sp,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
