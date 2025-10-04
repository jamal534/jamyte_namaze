import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class LanguageContainer extends StatelessWidget {
  LanguageContainer({
    super.key,
    required this.imagePath,
    required this.option,
    required this.onPressed,
    required this.isSelected,
    required this.isPaymentScreen,
    required this.isTrailingEnabled,
    this.fontSize,
  });

  final String imagePath;
  final String option;
  final double? fontSize;
  final void Function() onPressed;
  final bool isSelected;
  final bool isPaymentScreen;
  final bool isTrailingEnabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? Color(0xFF137058) : Color(0xFFDFE1E7),
          ),
          color: isSelected ? Color(0xFFBEF4E6) : Color(0xFFFFFFFF),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(color: isSelected ? Color(0xFFFFFFFF) : Color(0x33E2E8F0), shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    imagePath,
                    width: 20.w,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  option,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Color(0xFF20222C)
                  ),
                ),
              ),
              isTrailingEnabled == true
                  ? isPaymentScreen == false
                  ? Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_off,
                color: isSelected ? Color(0xFF137058) : Color(0xFFE2E8F0),
                size: 25.sp,
              )
                  : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5.w,
                    color: isSelected ? Colors.white : Color(0xFFE2E8F0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(1.w),
                  child: Icon(
                    Icons.circle,
                    size: 14.r,
                    color: isSelected ? Colors.grey : Colors.white,
                  ),
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
