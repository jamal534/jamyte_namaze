import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:jamayate_namaj/core/utils/asset_path.dart';
import 'package:jamayate_namaj/features/profile/controller/complaint_controller.dart';
import 'package:jamayate_namaj/core/global/custom_text.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/core/global/drowp_down_botton.dart';
import '../../controller/dorpdown.dart';
import 'package:video_player/video_player.dart';

class ComplaintPage extends StatelessWidget {
  ComplaintPage({super.key});

  final ComplaintController complaintController = Get.put(ComplaintController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomTextInter(
          text: 'complaint'.tr,
          color: Color(0xFF20222C),
          fontWeight: FontWeight.w600,
          size: 20.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextInter(
                text: 'complainType'.tr,
                fontWeight: FontWeight.w500,
                size: 16.sp,
                color: Color(0xFF20222C),
              ),
              SizedBox(height: 10.h),
              CustomDropdownButton(
                selectedValue: ChooseCar.carSelectedValue!,
                items: ChooseCar.carItems,
                onChanged: ChooseCar().onChanged,
                image: Image.asset(AssetPath.drowp_down),
                showLabel: false.obs,
              ),
              SizedBox(height: 10.h),
              CustomTextInter(
                text: 'description'.tr,
                fontWeight: FontWeight.w500,
                size: 16.sp,
                color: Color(0xFF20222C),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.w, color: Color(0xFFDFE1E7)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextInter(
                        text: "Placeholder",
                        color: Color(0xFF718096),
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: complaintController.description,
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextInter(
                            text: "0/200",
                            color: Color(0xFF718096),
                            fontWeight: FontWeight.w400,
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              InkWell(
                  onTap: (){
                    complaintController.pickVideoFromStorage();
                  },
                  child: DottedBorder(
                    strokeWidth: 2.w,
                    color: Color(0xFFDFE1E7),
                    dashPattern: [10, 10],
                    radius: Radius.circular(12.r),
                    child: Container(
                      height: 167.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffF4F6F9)
                      ),
                      child:Obx(() {
                        if (complaintController.selectedFile.value == "") {
                          return Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_album_outlined,size: 40,),
                              Text("Upload Photo Or Video"),
                            ],
                          ));
                        } else {
                          final filePath = complaintController.selectedFile.value;
                          if (filePath.endsWith('.mp4') || filePath.endsWith('.mkv')) {
                            return VideoPlayerWidget(filePath: filePath);
                          } else {
                            return Image.file(File(filePath),);
                          }
                        }
                      }), ),
                  ),
                ),


              SizedBox(height: 20.h),
              Obx(
                ()=>complaintController.isLoading.value?Center(child: CircularProgressIndicator(),): CustomButton(
                  text: 'submit'.tr,
                  onPressed: () async {
                    if(complaintController.description.text=="" || complaintController.selectedFile.value.isEmpty){
                      Get.snackbar("Required", "Please Select All input Filed");
                    }else{
                      await complaintController.submitComplaint(
                        ChooseCar.carSelectedValue!,
                        complaintController.description.text,
                      );
                    }

                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}


class VideoPlayerWidget extends StatefulWidget {
  final String filePath;

  VideoPlayerWidget({required this.filePath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(child: CircularProgressIndicator());
  }
}