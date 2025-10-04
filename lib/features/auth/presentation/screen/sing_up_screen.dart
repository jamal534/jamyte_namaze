import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/core/global/custom_password.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:jamayate_namaj/core/global/text_from_field.dart';
import 'package:jamayate_namaj/core/helper/from_validation.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';
import 'package:jamayate_namaj/features/auth/controller/social_login.dart';
import 'package:jamayate_namaj/features/auth/controller/switch_controller.dart';
import 'package:jamayate_namaj/features/auth/presentation/widget/social_container.dart';
import '../../../../core/app_route/app_route.dart';
import '../../controller/sing_up_controller.dart';

class SingUpScreen extends StatelessWidget {
  SingUpScreen({super.key});

  // final AuthController authenticationController = Get.put(AuthController());
  final singUPFormKey = GlobalKey<FormState>();
  final SignUpController signUpController = Get.put(SignUpController());

  final SwitchController controller = Get.put(SwitchController());


  final SocialLogin socialLoginController = Get.put(SocialLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          key: singUPFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
              CustomTextInter(
                text: "Sign Up",
                size: 24.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF20222C),
              ),
              CustomTextInter(
                textAlign: TextAlign.start,
                text: "Create account and enjoy all services",
                size: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4A5568),
              ),
              SizedBox(height: 30.h,),
              CustomTextField(
                imagePath: AssetPath.profile,
                editingController: signUpController.userName,
                validator: FormValidation.validateUsername,
                hintText: "Username",
              ),
              SizedBox(height: 15.h,),
              CustomTextField(
                imagePath: AssetPath.email1,
                editingController: signUpController.emailText,
                validator: FormValidation.validateEmail,
                hintText: "Email",
              ),
              SizedBox(height: 15.h,),
              CustomPasswordField(
                controller: signUpController.passText,
                  validator: FormValidation.validatePassword,
                  hints: "Password"
              ),
              SizedBox(height: 30.h,),
              Obx(()=> signUpController.isLoading.value ?
              Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ):
                CustomButton(
                    text: "Sign UP",
                    onPressed: (){
                      if(singUPFormKey.currentState!.validate()){
                        signUpController.signUp();
                      }
                    }
                ),
              ),
              SizedBox(height: 50.h,),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xFFE2E8F0),
                      thickness: 2,
                      endIndent: 20,
                      indent: 6,
                    ),
                  ),
                  Text(
                    "Or Log In with",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4A5568),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xFFE2E8F0),
                      thickness: 2,
                      indent: 20,
                      endIndent: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h,),
           Obx(()=> socialLoginController.isLoading.value?  Center(
             child: CircularProgressIndicator(
               color: Colors.green,
             ),
           ) :
                 GestureDetector(
                  onTap: (){
                    socialLoginController.googleSignIn();
                  },
                  child: SocialContainer(
                    imagePath: AssetPath.google,
                    text: "Continue with Google",
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Don’t have an Account? ",
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF4A5568),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "Log In",
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF137058),
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(AppRoute.loginScreen);
                            },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h,)
            ],
          ),
        ),
      ),
    );
  }
}
