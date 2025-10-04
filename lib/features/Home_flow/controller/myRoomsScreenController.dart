import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/helper/shared_preference_helper.dart';
import 'package:jamayate_namaj/core/service_class/network_caller/model/network_response.dart';
import 'package:jamayate_namaj/core/service_class/network_caller/repository/network_caller.dart';
import 'package:jamayate_namaj/core/utils/app_urls.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/ChatScreen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MyRoomsScreenController extends GetxController{

RxBool isLoading=false.obs;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetmyRooms();
  }
ResponseData? responses;


  void GetmyRooms()async {
    SharedPreferencesHelper sp=await SharedPreferencesHelper();
    sp.setBool("isAdvertiser", false);


    isLoading.value = true;
    try {
      ResponseData response = await NetworkCaller().getRequest(
          AppUrls.my_rooms);

      if (response.statusCode == 200) {
        if (response.responseData["totalRooms"] != 0) {
          responses = response;

          debugPrint(" Total rooms Grater than 0");
        }else{
          responses=null;
        }
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "An error occurred while fetching data.");
    }

    finally {
      isLoading.value = false;
    }
  }


WebSocketChannel? _channel;

Function(String)? onMessageReceived;

void setOnMessageReceived(Function(String) callback) {
  onMessageReceived = callback;
}

RxBool joinLoading = false.obs;
RxString jId="".obs;
RxString uId="".obs;

void joinJamaAt(String jamaatId, String userId)async {
  jId.value=jamaatId;
  uId.value=userId;
  SharedPreferencesHelper sp=await SharedPreferencesHelper();

  sp.setString("jId", jId.value);
  sp.setString("uId", uId.value);

  joinLoading.value = true;
  try {
    _channel = WebSocketChannel.connect(Uri.parse('wss://salahmarhaba.com'));
    // isConnected.value = true;
    debugPrint("=======================?>>>>>>>>onnected .");
    final subscribeMessage = jsonEncode({
      "type" : "subscribe",
      "jamatId" : jamaatId,
      "userId" : userId
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
  joinLoading.value = false;
}

void _handleMessage(String message) {
  joinLoading.value = true;
  final decodedMessage = jsonDecode(message);

  debugPrint("=========================>>$message");

  if (decodedMessage['error'] == "You are not in this group, please send a join request") {

    Get.snackbar("Notice", decodedMessage['error']);
  }
 else if (decodedMessage['error'] == "Your request still pending in this group") {

    Get.snackbar("Notice", decodedMessage['error']);
  }
 else if (decodedMessage['error'] == "You have rejected in this group by advertiser") {

    Get.snackbar("Notice", decodedMessage['error']);
  }



  else {

    Get.to(()=>ChatScreen(userId: uId.value, jamaatId: jId.value));
  }
  joinLoading.value = false;
}





}