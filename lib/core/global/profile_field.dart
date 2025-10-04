import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileField extends StatelessWidget {
  final String hintText;
  final TextEditingController editingController;
  final String? Function(String?)? validator;
  final String? imagePath;
  final TextStyle? hintStyle;

  ProfileField({
    Key? key,
    this.validator,
    required this.editingController,
    required this.hintText,
    this.imagePath,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Color(0xFFDFE1E7),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 15.w,),
          Image.asset(imagePath!,width: 25.w,),
          Expanded(
            child: TextFormField(
              validator: validator,
              controller: editingController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
