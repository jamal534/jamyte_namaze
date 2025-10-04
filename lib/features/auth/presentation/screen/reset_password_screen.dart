import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:jamayate_namaj/core/helper/from_validation.dart';
import '../../../../core/global/reset_password_field.dart';
import '../../controller/auth_controller.dart';
import '../../controller/forgot_password_controller.dart';


class ResetPassword extends StatelessWidget {
  final String selectedMethod;
  ResetPassword({super.key, required this.selectedMethod});

  final forgotController = Get.put(ForgotPasswordController());

  final AuthController authenticationController = Get.put(AuthController());
  final resetFormKey = GlobalKey<FormState>();

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
            child: Icon(
                Icons.arrow_back_ios
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: resetFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             CustomTextInter(
                 text: "Reset Password",
               fontWeight: FontWeight.w600,
               size: 24.sp,
               color: Color(0xFF20222C),
             ),
              Text(
                "Enter your $selectedMethod, we will send a verification code to your $selectedMethod",
                style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xFF718096)),
              ),
              SizedBox(height: 20.h),
              if (selectedMethod == "email")
                ResetPasswordField(
                  editingController: forgotController.forgotText,
                  validator: FormValidation.validateEmail,
                  hintText: "hello@rafiislam",
                  icon: Icons.email,
                  iconColor: Color(0xFF137058),
                ),
              if (selectedMethod == "phone")
                ResetPasswordField(
                  icon: Icons.phone,
                  iconColor: Color(0xFF20222C),
                  editingController: forgotController.forgotPhone,
                  validator: FormValidation.validatePhone,
                  hintText: "(+1) 446565214|",
                ),
              Spacer(),
              Obx(()=> forgotController.isLoading.value ? Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ):
                 CustomButton(
                    text: "Send Code",
                    onPressed: () async{
                      if(resetFormKey.currentState!.validate()){
                       await forgotController.forgotPassword(selectedMethod);
                      }
                    }),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
