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
import 'package:jamayate_namaj/features/auth/controller/login_controller.dart';
import 'package:jamayate_namaj/features/auth/presentation/widget/social_container.dart';
import '../../../../core/app_route/app_route.dart';
import '../../controller/social_login.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  final loginFormKey = GlobalKey<FormState>();

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
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              CustomTextInter(text: "Hey! Welcome back",
                  size: 24.sp, fontWeight: FontWeight.w600,
                  color: Color(0xFF20222C)),
              CustomTextInter(textAlign: TextAlign.start,
                  text: "Sign In to your account", size: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4A5568)),
              SizedBox(height: 30.h),
              CustomTextField(imagePath: AssetPath.email1,
                  validator: FormValidation.validateEmail,
                  editingController: loginController.emailText,
                  hintText: "Email"),
              SizedBox(height: 15.h),
              CustomPasswordField(controller: loginController.passText,
                  validator: FormValidation.validatePassword,
                  hints: "Password"),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            activeColor: Colors.white,
                            activeTrackColor: Color(0xFF3BDEB5),
                            value: loginController.isRememberMe.value,
                            onChanged: (value) {
                              loginController.isRememberMe.value = value;
                              print("Remember Me: ${loginController.isRememberMe.value}");

                              if (loginController.isRememberMe.value) {
                                print("Email: ${loginController.emailText.text}");
                                print("Password: ${loginController.passText.text}");
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: CustomTextInter(text: "Remember Me",
                      fontWeight: FontWeight.w400,
                      size: 12.sp, color: Color(0xFF20222C))),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoute.forgotPassword);
                        },
                        child: CustomTextInter(text: "Forgot Password?",
                            color: Color(0xFF137058),
                            fontWeight: FontWeight.w400,
                            size: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Obx(
                () =>
                    loginController.isLoading.value
                        ? Center(child: CircularProgressIndicator(color: Colors.green))
                        : CustomButton(
                          text: "LogIn",
                          onPressed: () async {
                            if (loginFormKey.currentState!.validate()) {
                              await loginController.logIn();
                              // Get.toNamed(AppRoute.navBar);
                            }
                          },
                        ),
              ),
              SizedBox(height: 40.h),
              Row(
                children: [
                  Expanded(child: Divider(color: Color(0xFFE2E8F0),
                      thickness: 2, endIndent: 20, indent: 6)),
                  Text("Or Log In with",
                      style: GoogleFonts.inter(fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4A5568))),
                  Expanded(child: Divider(color: Color(0xFFE2E8F0),
                      thickness: 2, indent: 20,
                      endIndent: 10)),
                ],
              ),
              SizedBox(height: 30.h),
              Obx(()=> socialLoginController.isLoading.value ?
              Center(child: CircularProgressIndicator(color: Colors.green)) :
                 GestureDetector(
                  onTap: () {
                    socialLoginController.googleSignIn();
                  },
                  child: SocialContainer(imagePath: AssetPath.google,
                      text: "Continue with Google"),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Don’t have an Account? ",
                      style: GoogleFonts.manrope(color: const Color(0xFF4A5568),
                          fontSize: 14.sp, fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: GoogleFonts.manrope(color: const Color(0xFF137058),
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoute.singUpScreen);
                                },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
