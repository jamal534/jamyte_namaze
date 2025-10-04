import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownButton extends StatelessWidget {
  final double? width;
  final Widget? image;
  final String? hintText;
  final String? selectedValue;
  final List<String> items;
  final Function(String?) onChanged;
  final RxBool showLabel;
  final TextStyle? textStyle;
  

  const CustomDropdownButton({
    super.key,
    this.hintText,
    this.textStyle,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.image,
    this.width,
    required this.showLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText ?? 'Select an option',
            hintStyle: textStyle ??
                GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF4A5568),
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Color(0xFFDFE1E7),
                width: 1.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Color(0xFFDFE1E7),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Color(0xFFDFE1E7),
                width: 1.w,
              ),
            ),
          ),
          dropdownColor: Colors.white,
          value: selectedValue,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: textStyle ??
                    GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF718096),
                    ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          icon: image ?? Icon(Icons.arrow_drop_down_outlined, size: 24.w),
        ),
      ],
    );
  }
}
