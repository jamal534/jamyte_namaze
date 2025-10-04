import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jamayate_namaj/core/service_class/network_caller/model/network_response.dart';
import 'package:jamayate_namaj/core/service_class/network_caller/repository/network_caller.dart';
import 'package:jamayate_namaj/core/utils/app_urls.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Model/pending_data_model.dart';

class GroupRequestScreenController extends GetxController {
  WebSocketChannel? _channel;
  RxBool isLoading = false.obs;

  Function(String)? onMessageReceived;

  void setOnMessageReceived(Function(String) callback) {
    onMessageReceived = callback;
  }

  void connect(String uid, String jamat_id) {
    // userId.value = senderId;
    // this.receiverId.value = receiverId;
    isLoading.value = true;

    try {
      _channel = WebSocketChannel.connect(Uri.parse('wss://salahmarhaba.com'));
      // isConnected.value = true;
      debugPrint("=======================?>>>>>>>>onnected .");
      final subscribeMessage = jsonEncode({
        "type": "subscribe",
        "jamatId": jamat_id,
        "userId": uid,
      });

      _channel!.sink.add(subscribeMessage);
      debugPrint("=======================?>>>>>>>>onnected and room joined.");

      _channel!.stream.listen(
        (message) {
          debugPrint("Received======================: $message");
          onMessageReceived?.call(message);
          _handleMessage(message);


          update();
        },
        onError: (error) {
          debugPrint('WebSocket Error: $error');
          //  isConnected.value = false;
        },
        onDone: () {
          debugPrint('WebSocket Closed');
          //  isConnected.value = false;
        },
      );
    } catch (e) {
      debugPrint('WebSocket Connection Failed: $e');
      //  isConnected.value = false;
    }
  }

  RxString jamaatId = "".obs;
  RxString msg = "".obs;
  RxList<User> pendingUsers = <User>[].obs;

  void _handleMessage(String message) {
    final decodedMessage = jsonDecode(message);

    debugPrint("=========================>>$message");


    if (decodedMessage['type'] == 'count-request') {

     jamaatId.value = decodedMessage['jamatId'];
      int len = decodedMessage['pendingInfo'].length;
      msg.value = decodedMessage["message"];
pendingUsers.clear();
      for (int i = 0; i < len; i++) {
        var lat = decodedMessage['pendingInfo'][i]["latitude"];
        var lng = decodedMessage['pendingInfo'][i]["longitude"];

        var named = decodedMessage['pendingInfo'][i]["user"];
        pendingUsers.add(
          User(
            id: named["id"],
            profileImage: named["profileImage"],
            username: named["username"],
          ),
        );
        addMarkers(lat, lng);
      }
    }
    isLoading.value = false;
  }

  void addMarkers(double lat, double lng) {
    markers.add(
      Marker(
        markerId: MarkerId('$lat,$lng'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: 'Pending Request'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }

  RxSet<Marker> markers = <Marker>{}.obs;
  GoogleMapController? mapController;

  void acceptAll() {
    final accpetalls = jsonEncode({
      "type": "accept-all",
      "jamatId": jamaatId.value,
      "status": "ACCEPTED",
    });

    _channel!.sink.add(accpetalls);
  }

  void changeStatus(String id,String status) {
    final accpetalls = jsonEncode({
      "type" : "change-status",
      "jamatId" : jamaatId.value,
      "userId" : id,
      "status" : status
    });

    _channel!.sink.add(accpetalls);
  }

  void leaveGroup()async{

    isLoading.value=true;

    try{

      ResponseData response=await NetworkCaller().postWithoutBody(AppUrls.leave);
      if(response.statusCode==200){
        debugPrint("Leave Jamat successfully");

        Get.back();
      }else if(response.statusCode==409){
        Get.snackbar("error", "You already leave this jamat");
      }
    }catch(e){
      debugPrint(e.toString());
    }finally{
      isLoading.value=false;
    }

  }



  void showUserDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 400.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      '${pendingUsers.length} request',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        acceptAll();
                      },
                      child: Text(
                        'Accept all',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                Obx(() {
                  if (pendingUsers.isEmpty) {
                    return Text('No users available.');
                  } else {
                    return Expanded(
                      // Expanded allows ListView to take available space in the Column
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: pendingUsers.length,
                        itemBuilder: (context, index) {
                          final user = pendingUsers[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,

                                    child: ClipOval(
                                      child: Image.network(
                                        user.profileImage,
                                        fit:
                                            BoxFit
                                                .cover, // Ensures the image fills the circle
                                        width:
                                            40, // Adjust the width and height for the circular shape
                                        height: 40,
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 6.w),
                                  Text(
                                    user.username,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {

                                    changeStatus(user.id, "ACCEPTED");

                                    },

                                    child: Container(
                                      height: 30.h,
                                      width: 61.w,
                                      decoration: BoxDecoration(
                                        color: Color(0xff137058),

                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Add",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 10.w),
                                  InkWell(
                                    onTap: () {
                                      changeStatus(user.id, "REJECTED");
debugPrint("done");
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                      size: 30.r,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                }),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
