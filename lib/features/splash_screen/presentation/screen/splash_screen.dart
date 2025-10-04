import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';

import '../../controller/splash_controller.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AssetPath.splashScreen,
              ),fit: BoxFit.cover
          ),
        ),child:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SpinKitCircle(
            color: Colors.white,
            size: 60.0,),
            SizedBox(height: 80.h,)
          ],
        ),
      ),
    );
  }
}
