import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';

class UserpasswordField extends StatelessWidget {
  RxBool isVisible = true.obs;

  final String hints;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  UserpasswordField(
      {super.key, required this.hints, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        // color: Color(0xFFDFE1E7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Color(0xFFE2E8F0),
          width: 1, // Border width
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 15.h,),
          Image.asset(AssetPath.lock,width: 25.w,),
          Expanded(
            child: Obx(
                  () => TextFormField(
                validator: validator,
                obscureText: isVisible.value,
                controller: controller,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                      color: Color(0xff1F2C37),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                  hintText: hints,
                  errorMaxLines: 3,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          InkWell(
            onTap: () {
              if (isVisible.value == true) {
                isVisible.value = false;
              } else {
                isVisible.value = true;
              }
            },
            child: Obx(
                  () => isVisible == true
                  ? Icon(Icons.visibility_off_outlined,color: Color(0xFF718096),)
                  : Icon(Icons.visibility_outlined,color: Color(0xFF718096),),
            ),
          ),
          SizedBox(
            width: 18,
          ),
        ],
      ),
    );
  }
}
