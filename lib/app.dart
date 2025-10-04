import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/app_route/app_route.dart';
import 'core/binding/binding.dart';
import 'core/global/app_translation.dart';

class MyApp extends StatelessWidget {

  final Locale locale;

  const MyApp({super.key,required this.locale});

  @override
  Widget build(BuildContext context) {


    bool isArabic = Get.locale?.languageCode == 'ar';

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: GetMaterialApp(
            initialBinding: AppBinding(),
            locale: locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFFFFFFFF),
              useMaterial3: true,
            ),
            translations: AppTranslations(),
            fallbackLocale: Locale('en', 'US'),
            getPages: AppRoute.route,
            transitionDuration: const Duration(milliseconds: 200),
            navigatorKey: Get.key,
            initialRoute: AppRoute.splashScreen,
          ),
        );
      },
    );
  }
}
