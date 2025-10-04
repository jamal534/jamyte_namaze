import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/helper/from_validation.dart';
import '../../controller/forgot_password_controller.dart';

class ResetPasswordVerify extends StatelessWidget {
  ResetPasswordVerify({super.key, required this.selectedMethod});

  final String selectedMethod;

  final otpFormKey = GlobalKey<FormState>();
  // final AuthController authenticationController = Get.put(AuthController());
  final forgotPasswordController = Get.put(ForgotPasswordController());

  final RxDouble secondsRemaining = 0.43.obs;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0.0) {
        secondsRemaining.value -= 0.01;
      } else {
        secondsRemaining.value = 0.0;
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer();

    return Scaffold(
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
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: otpFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextInter(
                text: "Verification Code",
                color: Color(0xFF20222C),
                fontWeight: FontWeight.w600,
                size: 24.sp,
              ),
              CustomTextInter(
                text:
                    "Enter the verification code that we have sent to your email",
                color: Color(0xFF4A5568),
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
              SizedBox(height: 30.h),
              Pinput(
                length: 4,
                keyboardType: TextInputType.number,
                controller: forgotPasswordController.pinput,
                validator: FormValidation.validatePin,
                defaultPinTheme: PinTheme(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  textStyle: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF120D26),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.w,
                    ),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  height: 60,
                  width: 60,
                  textStyle: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE2E8F0),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF337617),
                      width: 1.w,
                    ),
                  ),
                ),
                onCompleted: (value) {
                  // otpController.otpController.text = value;
                  // errorMessage.value = '';
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    // errorMessage.value = '';
                  }
                },
              ),
              SizedBox(height: 40.h),
              Obx(
                () =>
                    forgotPasswordController.isLoading.value
                        ? Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        )
                        : CustomButton(
                          text: "Continue",
                          onPressed: () async {
                            if (otpFormKey.currentState!.validate()) {
                              // forgotPasswordController.ForgotPasswordVerify(selectedMethod : );
                              await forgotPasswordController.ForgotPasswordVerify(
                                selectedMethod,
                              );
                            }
                          },
                        ),
              ),
              SizedBox(height: 30.h),
              Obx(() {
                return Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async{
                      if (secondsRemaining.value == 0.0) {
                        await forgotPasswordController.forgotPassword(
                            selectedMethod);

                        secondsRemaining.value = 0.59;
                        startTimer();
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [

                          TextSpan(
                            text: "Re-send code in ",
                            style: GoogleFonts.inter(
                              color: const Color(0xFF20222C),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                          TextSpan(
                            text:
                                secondsRemaining.value == 0.0
                                    ? ""
                                    : "${secondsRemaining.value.toStringAsFixed(2)}",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: const Color(0xFF137058),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
