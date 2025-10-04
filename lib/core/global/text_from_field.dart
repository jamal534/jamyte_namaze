import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController editingController;
  final String? Function(String?)? validator;
  final String? imagePath;

  CustomTextField({
    Key? key,
    this.validator,
    required this.editingController,
    required this.hintText,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: Color(0xFFDFE1E7),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 10.w,),
         Image.asset(imagePath!,width: 20.w,),
          Expanded(
            child: TextFormField(
              autofocus: true,
              enableInteractiveSelection: true,
              validator: validator,
              controller: editingController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodySmall,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  top: 0.h,
                  bottom: 7.h,
                  left: 15.h,
                  right: 0.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
