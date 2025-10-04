import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';

class CustomPasswordField extends StatelessWidget {
  RxBool isVisible = true.obs;

  final String hints;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  CustomPasswordField(
      {super.key, required this.hints, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        // color: Color(0xFFDFE1E7),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Color(0xFFDFE1E7),
          width: 1, // Border width
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.h,),
          Image.asset(AssetPath.lock,width: 20.w,),
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
