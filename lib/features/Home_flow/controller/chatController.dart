import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends GetxController {
  WebSocketChannel? _channel;
  RxList<Map<String, String>> messages = <Map<String, String>>[].obs;
  RxString userId = "".obs;
  RxString jamaatId = "".obs;

  var isConnected = false.obs;

  void connect(String jamaatID, String usersId) {
    userId.value = usersId;
    jamaatId.value = jamaatID;

    try {
      _channel = WebSocketChannel.connect(Uri.parse('wss://salahmarhaba.com'));
      // isConnected.value = true;
      debugPrint("=======================?>>>>>>>>onnected .");
      isConnected.value = true;

      final subscribeMessage = jsonEncode({
        "type": "subscribe",
        "jamatId": jamaatID,
        "userId": usersId,
      });

      _channel!.sink.add(subscribeMessage);
      _channel!.stream.listen(
        (message) {
          debugPrint("Received: $message");
          _handleMessage(message);
          update();
        },
        onError: (error) {
          debugPrint('WebSocket Error: $error');
          isConnected.value = false;
        },
        onDone: () {
          debugPrint('WebSocket Closed');
          isConnected.value = false;
        },
      );
    } catch (e) {
      debugPrint('WebSocket Connection Failed: $e');
      isConnected.value = false;
    }
  }

  void _handleMessage(String message) {
    final decodedMessage = jsonDecode(message);

    if (decodedMessage['type'] == 'pastMessages') {
      _handlePastMessages(decodedMessage['message']);
    }else if(decodedMessage['error'] == 'You cannot send message, becouse you already leave this group'){
      Get.snackbar("Notice", "You cannot send message, because you already leave this group ");
      Get.back();
    }
  }

  void _handlePastMessages(List<dynamic> messagesData) {
    messages.clear();
    for (var message in messagesData) {
      messages.insert(0, {
        "senderId": message["userId"] ?? "",
        "message": message["message"] ?? "",
        "usernames": message["user"]["username"] ?? "",
        "image": message["user"]["profileImage"] ?? "",
      });
    }
  }

  void leavefunction() {
    final sendMessage = jsonEncode({
      "type": "change-status",
      "jamatId": jamaatId.value,
      "userId": userId.value,
      "status": "LEFT",
    });

    _channel!.sink.add(sendMessage);

  }

  void sendMessage({required String message}) {
    if (!isConnected.value || _channel == null) {
      debugPrint("WebSocket not connected. Cannot send message.");
      return;
    }

    if (jamaatId.value.isEmpty) {
      debugPrint("Room ID is missing. Cannot send message.");
      return;
    }

    final sendMessage = jsonEncode({
      "type": "send-message",
      "jamatId": jamaatId.value,
      "userId": userId.value,
      "message": message,
    });

    _channel!.sink.add(sendMessage);
    debugPrint("Message sent: $message");
  }

  void close() {
    if (_channel != null) {
      _channel?.sink.close();
      isConnected.value = false;
      debugPrint("WebSocket connection closed.");
    }
  }
RxDouble lat=0.0.obs;
  RxDouble lng=0.0.obs;

  getCurrentLocation()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat.value=position.latitude;
    lng.value=position.longitude;

    debugPrint("lat===========${lat.value}");
    debugPrint("lng===========${lng.value}");


  }

}
