import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectVerify extends StatelessWidget {
  const SelectVerify({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 48,
    this.width = double.infinity,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.elevation = 5.0,
    this.textStyle,
    this.titleColor,
    this.borderColor,
    this.borderWidth,
    required this.icon,
    required this.containerColor,
  });

  final String title;
  final VoidCallback onTap;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double elevation;
  final TextStyle?textStyle;
  final Color? titleColor;
  final Color? borderColor;
  final double? borderWidth;
  final Color containerColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: borderColor != null ? Border.all(
            color: borderColor!,
            width: borderWidth!,
          ) : null,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                 shape: BoxShape.circle,
                  color: containerColor,
                ),child: icon,
              ),
              SizedBox(width: 10.h,),
              Text(
                title,
                style: GoogleFonts.lato(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
