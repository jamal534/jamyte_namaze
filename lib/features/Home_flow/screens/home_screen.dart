import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';

import 'package:jamayate_namaj/features/Home_flow/controller/home_screen_controller.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/select_location.dart';

import '../widgets/custom_dropdown.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
HomeScreenController controller =Get.put(HomeScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {

        if (controller.currentLat.value == 0.0 || controller.currentLng.value == 0.0) {
          return Center(child: CircularProgressIndicator());
        }

        return Stack(
          children:[
            Positioned(
              top: 0.h,
              left: 0.w,
              right: 0.w,
              height: Get.height-210,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:controller.lng.value==0.0? LatLng(controller.currentLat.value, controller.currentLng.value):LatLng(
                      controller.lat.value, controller.lng.value),
                  zoom: 12.0,
                ),
                onMapCreated: (GoogleMapController googleMapController) {
                  controller.mapController = googleMapController;
                },
                markers: controller.markers.value, // Reactive markers
              ),
            ),


            Positioned(
                top: 30.h,


                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child:controller.salahTime.value==""?SizedBox(): Container(
                                height: 50.h,
                    width: Get.width-35,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Center(
                      child: Text(controller.salahTime.value,style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff20222C)
                      ),),
                    ),


                              ),
                )),



            Positioned(
              top: Get.height-230,
              bottom: 0.0, // Position it at the bottom of the screen
              left: 0.0, // Align it to the left
              right: 0.0, // Align it to the right
              child: Container(
               // height: 178.h, // Set the height
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(12.r),
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(
                      ()=> Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            CustomDropdown(
                              dropdownKey: "Select Pray",
                              items: ["Praying Fajr", "Praying Juhr", "Praying Asr","Praying Magrib","Praying Isha", ],
                              onChanged: (value) {
                                debugPrint("Language Selected: $value");
                                controller.title.value=value;

                                if(controller.title.value!="" && controller.time.value!=""){
                                  controller.getData();
                                }
                              },
                            ),
                           controller.loading.value?Center(child: CircularProgressIndicator(),): CustomDropdown(
                              dropdownKey: "Time",
                              items: ["5 Minutes", "15 Minutes", "30 Minutes"],
                              onChanged: (value) {
                                debugPrint("Language Selected: ${value[0]+value[1]}");
                                controller.time.value=value[0]+value[1];

                                if(controller.title.value!="" && controller.time.value!=""){
                          controller.getData();
                                }
                              },
                            ),
                          ],),
                        ),
                      ),

                      CustomButton(text: " Select Location", onPressed: (){
if(controller.title.value!="" && controller.time.value!=""){
  Get.to(()=>SelectLocationScreeen(controller.currentLat.value, controller.currentLng.value,controller.title.value,controller.time.value ));

        }


                      },),
                    ],
                  ),
                ),
              ),
            ),
             
          ]
        );
      }),
    );
  }
}
