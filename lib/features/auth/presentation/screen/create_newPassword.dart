import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import '../../../../core/global/custom_password.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/helper/from_validation.dart';
import '../../controller/forgot_password_controller.dart';


class CreateNewPassword extends StatelessWidget {
   CreateNewPassword({super.key});

   // final AuthController authenticationController = Get.put(AuthController());

   final forgotPasswordController = Get.put(ForgotPasswordController());

   final createNewPass = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.h),
          child: GestureDetector(
            onTap: (){
              Get.back();
            },
              child: Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Form(
          key: createNewPass,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextInter(
                text: "Create New Password",
                color: Color(0xFF20222C),
                fontWeight: FontWeight.w600,
                size: 24.sp,
              ),
              CustomTextInter(
                text: "Your password must be different from previous used password",
                color: Color(0xFF4A5568),
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomPasswordField(
                controller: forgotPasswordController.newPassword,
                  validator: FormValidation.validatePassword,
                  hints: "New Password"
              ),
              SizedBox(height: 20.h,),
              CustomPasswordField(
                controller: forgotPasswordController.newConfirmPass,
                  validator: (value) => FormValidation.validatePasswordMatch(
                      value, forgotPasswordController.newPassword),
                  hints: "Confirm Password"
              ),
              SizedBox(height: 30.h,),
              Obx(()=> forgotPasswordController.isLoading.value ? Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ):
                 CustomButton(text: "Reset Password",
                    onPressed: (){
                      if (createNewPass.currentState!.validate()) {
                        if(forgotPasswordController.newPassword.text==forgotPasswordController.newConfirmPass.text) {
                          forgotPasswordController.setNewPassword();
                        }
                      }
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
