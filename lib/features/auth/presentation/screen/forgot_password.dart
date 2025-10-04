import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/features/auth/controller/switch_controller.dart';
import 'package:jamayate_namaj/features/auth/presentation/screen/reset_password_screen.dart';
import '../../../../core/global/select_verify.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword ({super.key});

  final ForgetController forgetController = Get.put(ForgetController());

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
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password",
              style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A202C)),
            ),
            Text(
              "Select with contact details should we use\nto reset yout password",
              style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF718096C)),
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              children: [
                Obx(() => SelectVerify(
                    containerColor: forgetController.selectedIndex.value == 0
                        ? Color(0xFFFFFFFF)
                        : Color(0xFFE0FAF3),
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.email_outlined,
                        size: 16.sp,
                        color: forgetController.selectedIndex.value == 0
                            ? Color(0xFF137058)
                            : Color(0xFF20222C),
                      ),
                    ),
                    borderColor: forgetController.selectedIndex.value == 0
                        ? Color(0xFF137058)
                        : Color(0xFFDFE1E7),
                    borderWidth: 1.0,
                    title: "********@mail.com",
                    textColor: forgetController.selectedIndex.value == 0
                        ? Color(0xFF137058)
                        : Color(0xFF718096),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    onTap: () {
                      forgetController.selectIndex(0);
                    },
                    backgroundColor: forgetController.selectedIndex.value == 0
                        ? Color(0xFFE0FAF3)
                        : Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(
                  height: 20.w,
                ),
                Obx(
                      () => SelectVerify(
                    containerColor: forgetController.selectedIndex.value == 1
                        ? Color(0xFFFFFFFF)
                        : Color(0xFFE0FAF3),
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone,
                        size: 16.sp,
                        color: forgetController.selectedIndex.value == 1
                            ? Color(0xFF137058)
                            : Color(0xFF20222C),
                      ),
                    ),
                    borderColor: forgetController.selectedIndex.value == 1
                        ? Color(0xFF137058)
                        : Color(0xFFDFE1E7),
                    borderWidth: 1.0,
                    title: "**** **** 24517",
                    textColor: forgetController.selectedIndex.value == 1
                        ? Color(0xFF137058)
                        : Color(0xFF718096),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    onTap: () {
                      forgetController.selectIndex(1);
                    },
                    backgroundColor: forgetController.selectedIndex.value == 1
                        ? Color(0xFFE0FAF3)
                        : Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
            Spacer(),
            CustomButton(
              text: "Continue",
              onPressed: () {
                Get.to(() => ResetPassword(
                  selectedMethod: forgetController.selectedIndex.value == 0
                      ? "email"
                      : "phone",
                ));
              },
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
