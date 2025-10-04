import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordField extends StatelessWidget {
  final String hintText;
  final TextEditingController editingController;
  final String? Function(String?)? validator;
  final IconData icon;
  final Color iconColor;


  ResetPasswordField({
    Key? key,
    this.validator,
    required this.editingController,
    required this.hintText,
    required this.icon,
    required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Color(0xFFDFE1E7),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.w,),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE0FAF3)
            ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon,size: 15.sp,color: iconColor),
              )),
          Expanded(
            child: TextFormField(
              validator: validator,
              controller: editingController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodySmall,
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
