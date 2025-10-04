import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/app_route/app_route.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';
import '../../../../core/global/custom_searchbar.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/helper/select_language_sharedprefer.dart';
import '../../../../core/helper/shared_preference_helper.dart';
import '../widget/language_container.dart';


class SelectLanguage extends StatelessWidget {
  SelectLanguage({super.key});

  final RxInt selectedItem = 0.obs;

  final RxList<Map<String, dynamic>> proFile = <Map<String, dynamic>>[
    {
      'image': AssetPath.usa,
      'title': 'English',
      'locale': Locale('en', 'US'),
    },
    {
      'image': AssetPath.arabic,
      'title': 'Arabic',
      'locale': Locale('ar', 'SA'),
    },
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Directionality(
          textDirection: selectedItem.value == 1 ? TextDirection.rtl : TextDirection.ltr,
          child: CustomTextInter(
            text: 'selectLanguage'.tr,
            color: Color(0xFF20222C),
            fontWeight: FontWeight.w600,
            size: 20.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CustomSearchBar(isEnabled: true, isHomeColor: false, height: 55.h),
            SizedBox(height: 30.h),
            Expanded(
              flex: 7,
              child: ListView.builder(
                itemCount: proFile.length,
                itemBuilder: (context, index) {
                  return Obx(
                        () => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: LanguageContainer(
                        imagePath: proFile[index]['image'],
                        option: proFile[index]['title'],
                        onPressed: () async {
                          // selectedItem.value = index;
                          // Get.updateLocale(proFile[index]['locale']);
                          //
                          // await SharePrefsHelper.setString('selected_language', proFile[index]['locale']);
                          // debugPrint("Selected language: ${proFile[index]['locale']}");


                          selectedItem.value = index;
                          Get.updateLocale(proFile[index]['locale']);

                          await SharedPrefsHelper.setLocale('user_locale', proFile[index]['locale']);

                          debugPrint("Selected language: ${proFile[index]['title']}");

                        },
                        isSelected: selectedItem.value == index,
                        isPaymentScreen: false,
                        isTrailingEnabled: true,
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: CustomButton(
                text: 'saveChange'.tr,
                onPressed: () async {
                  Get.toNamed(AppRoute.navBar);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
