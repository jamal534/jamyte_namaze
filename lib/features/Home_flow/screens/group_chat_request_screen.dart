import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jamayate_namaj/core/helper/shared_preference_helper.dart';
import 'package:jamayate_namaj/features/Home_flow/controller/GroupRequestScreenController.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/ChatScreen.dart';

import '../../../core/global/custom_bottom.dart';

class GroupChatRequestScreen extends StatefulWidget {
  String id;
  String jid;
  var lat;
  var lng;

  GroupChatRequestScreen(this.id, this.jid, this.lat, this.lng, {super.key});

  @override
  State<GroupChatRequestScreen> createState() => _GroupChatRequestScreenState();
}

class _GroupChatRequestScreenState extends State<GroupChatRequestScreen> {
  final GroupRequestScreenController controller = Get.put(
    GroupRequestScreenController(),
  );

  @override
  void initState() {
    super.initState();
    controller.connect(widget.id, widget.jid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Stack(
              children: [
                Positioned(
                  top: 0.h,
                  left: 0.w,
                  right: 0.w,
                  height: Get.height - 190,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.lat!, widget.lng!),
                      zoom: 12.0,
                    ),
                    onMapCreated: (GoogleMapController googleMapController) {
                      controller.mapController = googleMapController;
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
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30.r,
                    ),
                  ),
                ),

                // Bottom sheet (Custom button)
                Positioned(
                  top: Get.height - 210,
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
                          SizedBox(height: 10.h),
                          InkWell(
                            onTap: () {
                              controller.showUserDialog();
                            },
                            child: Container(
                              height: 52.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8000.sp),
                                color: Color(0xff1EB38E),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.msg.value,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 30.r,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 13.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                //  height:  52.h,
                                text: "Group Chat",
                                width: 165.w,
                                onPressed: () async {
                                  SharedPreferencesHelper sp =
                                      await SharedPreferencesHelper();

                                  sp.setString("jId", widget.jid);
                                  sp.setString("uId", widget.id);
                                  sp.setBool("isAdvertiser", true);

                                  Get.to(
                                    () => ChatScreen(
                                      userId: widget.id,
                                      jamaatId: widget.jid,
                                      ishome: false,
                                    ),
                                  );
                                },
                              ),
                              controller.isLoading.value
                                  ? Center(child: CircularProgressIndicator())
                                  : CustomButton(
                                    //   height: 52.h,
                                    text: "Leave Group",
                                    width: 165.w,
                                    backgroundColor: Colors.red.withOpacity(
                                      0.75,
                                    ),
                                    onPressed: () async {
                                      controller.leaveGroup();
                                    },
                                  ),
                            ],
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
