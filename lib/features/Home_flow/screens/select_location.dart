import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Add Google Place package
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:jamayate_namaj/features/Home_flow/controller/home_screen_controller.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';

import '../controller/SelectLocaitonController.dart';

class SelectLocationScreeen extends StatelessWidget {
  var lat;
  var lng;
  var titles;
  String times;

  SelectLocationScreeen(
    this.lat,
    this.lng,
    this.titles,
    this.times, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the LocationController
    LocationController controller = Get.put(LocationController());
    controller.lat.value = lat;
    controller.lng.value = lng;
    controller.time = times;
    controller.title.value = titles;

    controller.getLocationName(lng, lng);
    controller.addMarker();

    String namajTime =
        "${controller.title.value} in ${controller.time} minutes";

    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            Positioned(
              top: 0.h,
              left: 0.w,
              right: 0.w,
              height: Get.height - 230,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 12.0,
                ),
                onMapCreated: (GoogleMapController googleMapController) {
                  controller.mapController = googleMapController;
                },
                onLongPress: (LatLng latLng) {
                  debugPrint(
                    'Long pressed at: ${latLng.latitude}, ${latLng.longitude}',
                  );

                  controller.lat.value = latLng.latitude;
                  controller.lng.value = latLng.longitude;

                  controller.addMarkers('Selected Location');

                  controller.getLocationName(
                    controller.lat.value,
                    controller.lng.value,
                  );
                },
                markers: controller.markers.value, // Reactive markers
              ),
            ),

            // Back button
            Positioned(
              top: 45.h,
              left: 20.w,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back, color: Colors.black, size: 30.r),
              ),
            ),

            // Location search widget (to the right of the back button)
            Positioned(
              top: 40.h,
              left: 50.w,
              child: SizedBox(
                width: Get.width - 60,
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: controller.locationController,
                  googleAPIKey: "AIzaSyDHDcnjRGOXS1T9MRWK9XwfR-c8Rb0ufgM",
                  debounceTime: 500,
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    debugPrint("placeDetails = " + prediction.lng.toString());
                    controller.lat.value = double.parse(prediction.lat!);
                    controller.lng.value = double.parse(prediction.lng!);
                    debugPrint("latiture" + controller.lat.value.toString());
                    if (controller.mapController != null) {
                      controller.mapController!.animateCamera(
                        CameraUpdate.newLatLng(
                          LatLng(controller.lat.value, controller.lng.value),
                        ),
                      );
                    }

                    controller.addMarkers(controller.locationController.text);
                  },
                  itemClick: (Prediction prediction) {
                    debugPrint(prediction.description);
                    controller.locationController.text =
                        prediction.description.toString();
                    controller.locatonString.value =
                        prediction.description.toString();
                    debugPrint(prediction.lng);
                  },
                  boxDecoration: BoxDecoration(color: Colors.white),
                  itemBuilder: (context, index, prediction) {
                    return Container(
                      color: Colors.grey,
                      padding: EdgeInsets.all(10),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            prediction.description ?? "Unknown location",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                  inputDecoration: InputDecoration(
                    hintText: 'Search and Select Place', // Placeholder text
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(
                        0xff636F85,
                      ).withOpacity(0.6), // Hint text style
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),

            // Bottom sheet (Custom button)
            Positioned(
              top: Get.height - 250,
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0.r),
                        child: Obx(
                          () => Container(
                            height: 98.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              color: Color(0xffE0FAF3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                controller.locatonString.value == ""
                                    ? SizedBox()
                                    : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 25.r,
                                        ),
                                        Expanded(
                                          child: Text(
                                            controller.locatonString.value
                                                .toString(),
                                            style: GoogleFonts.inter(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff4A5568),
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 8.h),
                                      ],
                                    ),
                                Text(
                                  namajTime,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: Color(0xff718096),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 6.h),
                      controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : CustomButton(
                            text: "Tell People To Join Jama'at",
                            onPressed: () {
                              controller.createAdvertisement();
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
