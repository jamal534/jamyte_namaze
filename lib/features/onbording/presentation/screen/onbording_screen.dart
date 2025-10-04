import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/app_route/app_route.dart';
import 'package:jamayate_namaj/features/onbording/presentation/screen/slide.dart';
import 'package:jamayate_namaj/features/onbording/presentation/screen/slide_item.dart';
import 'package:jamayate_namaj/features/onbording/presentation/screen/slide_model.dart';
import '../../../../core/global/custom_bottom.dart';
import '../../controller/onbordin_controller.dart';


class OnbordingScreen extends StatelessWidget {
  OnbordingScreen({super.key});

  final PaseviewController controller = Get.put(PaseviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: slidList.length,
                itemBuilder: (context, index) {
                  return SlideItem(index);
                },
              ),
            ),
            Obx(
                  () => Center(
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < slidList.length; i++)
                        Slide(i == controller.currentPage.value)
                    ]),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: CustomButton(
                    text: "Next",
                    onPressed: () {
                      if (controller.currentPage.value <
                          slidList.length - 1) {
                        controller.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }else{
                        Get.toNamed(AppRoute.loginScreen);
                      }
              }),
            ),
            SizedBox(height: 20.h,)
          ],
        ),
      ),
    );
  }
}
