import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';
import 'package:jamayate_namaj/features/auth/controller/login_controller.dart';


class LogoutDialog extends StatelessWidget{


  final LoginController loginController = Get.put(LoginController());

  final RxInt selectedItem = 0.obs;

   LogoutDialog ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.sp),
        color: Color(0xFFFEFEFE),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            AssetPath.question,
            height: 101.h,
            width : 101.w,
          ),
          CustomTextInter(
            textAlign: TextAlign.center,
            text: 'areYor'.tr,
            fontWeight: FontWeight.w600,
            size: 20.sp,
            color: Color(0xFF20222C),
          ),
          CustomTextInter(
            textAlign: TextAlign.center,
            text: 'doYo'.tr,
            fontWeight: FontWeight.w400,
            size: 16.sp,
            color: Color(0xFF20222C),
          ),
          SizedBox(
            height: 20.h,
          ),
          Obx (()=>
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await LoginController.logoutUser();
                    Get.back();
                  },
                  child: Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.w,
                        color: selectedItem.value == 1 ? Color(0xFF137058) : Color(0xFF137058),
                      ),
                      borderRadius: BorderRadius.circular(100.r),
                      color: selectedItem.value == 1 ? Color(0xFF137058) : Color(0xFFFFFFFF)
                    ),child: Center(
                    child: CustomTextInter(
                        text: 'logout'.tr,
                      fontWeight: FontWeight.w600,
                      size: 14.sp,
                      color: selectedItem.value == 1 ? Color(0xFFFDFDFD) : Color(0xFF137058),
                    ),
                  ),
                  ),
                ),
                SizedBox(width: 10.w,),
                GestureDetector(
                  onTap: (){
                        () => selectedItem.value = 0;
                        Get.back();
                  },
                  child: Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.w,
                          color: selectedItem.value == 0 ? Color(0xFF137058) : Color(0xFF137058),
                        ),
                        borderRadius: BorderRadius.circular(100.r),
                        color: selectedItem.value == 0 ? Color(0xFF137058) : Color(0xFFFFFFFF)
                    ),child:  Center(
                    child: CustomTextInter(
                      text: 'cancel'.tr,
                      fontWeight: FontWeight.w600,
                      size: 14.sp,
                      color: selectedItem.value == 0 ? Color(0xFFFDFDFD) : Color(0xFF137058),
                    ),
                  ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
