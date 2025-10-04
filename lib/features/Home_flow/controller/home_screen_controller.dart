import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jamayate_namaj/core/global/custom_bottom.dart';
import 'package:jamayate_namaj/core/helper/shared_preference_helper.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/myRooms_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../core/service_class/network_caller/model/network_response.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/utils/app_urls.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLocation();
  }

  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  RxString title = "".obs;
  RxString time = "".obs;

  RxSet<Marker> markers = <Marker>{}.obs; // Observable set of markers
  GoogleMapController? mapController;

  ResponseData? responses;
  RxBool loading = false.obs;
  getData() async {
    debugPrint(DateTime.now().toString());

    try {
      loading.value = true;
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLat.value = position.latitude;
      currentLng.value = position.longitude;

      debugPrint('Latitude=======: ${currentLat.value}');
      debugPrint('Longitude=======: ${currentLng.value}');

      int times = int.parse(time.value);
      ResponseData response = await NetworkCaller().getRequest(
        "https://salahmarhaba.com/api/v1/advertising/find-advertise?title=${title}&endAt=${times}&latitude=${currentLat.value}&longitude=${currentLng.value}",
      );

      if (response.statusCode == 200) {
        responses = response;
        markers.clear();
        if (response.responseData == null || response.responseData.isEmpty) {
          debugPrint('Response data is null or empty');
        } else {
          lat.value = responses!.responseData[0]["adLocation"][0]["latitude"];
          lng.value = responses!.responseData[0]["adLocation"][0]["longitude"];
        }

        markerPositions.clear(); // Clear previous positions
        for (int i = 0; i < response.responseData.length; i++) {
          final lat = responses?.responseData[i]["adLocation"][0]["latitude"];
          final lng = responses?.responseData[i]["adLocation"][0]["longitude"];

          if (lat != null && lng != null) {
            markerPositions.add(LatLng(lat, lng)); // Populate marker positions
          }
        }
        addMarkers();
      } else {
        Get.snackbar('Error', response.errorMessage.toString());
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    } finally {
      loading.value = false;
    }
  }

  DateTime? dt = DateTime.now();

  String getStrings(int i) {
    int receiveTime = responses?.responseData[i]["endAt"];

    int currentTime = DateTime.now().millisecondsSinceEpoch;

    // Calculate the difference in milliseconds
    int differenceInMilliseconds = receiveTime - currentTime;

    // Convert milliseconds to minutes
    int min = (differenceInMilliseconds / 60000).round();
    return "${title} in ${min} minutes";
  }

  List<LatLng> markerPositions = [];
  void addMarkers() async {
    markers.clear();

    for (var i = 0; i < responses?.responseData.length; i++) {
      final marker = Marker(
        markerId: MarkerId('i'),
        position: markerPositions[i],
        infoWindow: InfoWindow(title: getStrings(i)),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {
          Get.bottomSheet(
            Container(
              height: 130.h, // Set height to 300
              width: double.infinity, // Set width to double infinity
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the bottom sheet
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), // Set top-left radius
                  topRight: Radius.circular(16), // Set top-right radius
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Obx(
                    () =>
                        joinLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : CustomButton(
                              text: ("Join the Jama,at"),
                              onPressed: () async{
                                var jamaatId = responses?.responseData[i]["id"];
                                SharedPreferencesHelper sp=await SharedPreferencesHelper();
                                String? userID =sp.getString("myUserId");

                                debugPrint("user jamatid============$jamaatId");
                                debugPrint("user userid============$userID");
                                joinJamaAt(jamaatId, userID!);
                              },
                            ),
                  ),
                ),
              ),
            ),
            isScrollControlled: true, // Make the bottom sheet height controlled
          );
        },
      );
      markers.add(marker);
    }
    _addMarker();
  }

  void _addMarker() {
    markers.add(
      Marker(
        markerId: MarkerId('target_location'),
        position: LatLng(currentLat.value, currentLng.value),
        infoWindow: InfoWindow(title: 'Current Location'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  WebSocketChannel? _channel;

  Function(String)? onMessageReceived;

  void setOnMessageReceived(Function(String) callback) {
    onMessageReceived = callback;
  }

  RxBool joinLoading = false.obs;

  void joinJamaAt(String jamaatId, String userId) {
    joinLoading.value = true;
    try {
      _channel = WebSocketChannel.connect(Uri.parse('wss://salahmarhaba.com'));
      // isConnected.value = true;
      debugPrint("=======================?>>>>>>>>onnected .");
      final subscribeMessage = jsonEncode({
        "type": "send-request",
        "jamatId": jamaatId,
        "userId": userId, //userId
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

    if (decodedMessage['error'] == "You already joined this jamat") {
      Get.to(() => MyroomsScreen());
      Get.snackbar("Notice", decodedMessage['error']);

    } else if (decodedMessage['error'] == "This Advertising is not exist") {
      Get.snackbar("Notice", decodedMessage['error']);

    } else if (decodedMessage["message"] == "Request sent successfully") {
      Get.to(() => MyroomsScreen());
    }
    joinLoading.value = false;
  }

  Future<bool?> getLocation() async {
    isLoading.value = true;
    if (Platform.isIOS) {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled.');
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied.');
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permissions are permanently denied.');
        return false;
      }

      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        currentLat.value = position.latitude;
        currentLng.value = position.longitude;

        SharedPreferencesHelper sp=SharedPreferencesHelper();
        sp.setDouble("lat", currentLat.value);
        sp.setDouble("lng", currentLng.value);

        debugPrint('Latitude=======: ${currentLat.value}');
        debugPrint('Longitude=======: ${currentLng.value}');
        sendLocation();
        // Add marker to map after getting the location
        _addMarker();

        // Move camera to the current location
        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLng(LatLng(currentLat.value, currentLng.value)),
          );
        }

        return true;
      } catch (e) {
        debugPrint('Error fetching location: $e');
      }
    } else if (Platform.isAndroid) {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled.');
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied.');
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permissions are permanently denied.');
        return false;
      }

      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        currentLat.value = position.latitude;
        currentLng.value = position.longitude;

        debugPrint('Latitude=======: ${currentLat.value}');
        debugPrint('Longitude=======: ${currentLng.value}');

        sendLocation();
        // Add marker to map after getting the location
        _addMarker();

        // Move camera to the current location
        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLng(LatLng(currentLat.value, currentLng.value)),
          );
        }

        return true;
      } catch (e) {
        debugPrint('Error fetching location: $e');
      }
    } else {
      debugPrint('This function is designed to run on iOS only.');
    }
    isLoading.value = false;
  }

  RxString salahTime = "".obs;

  void sendLocation() async {
    DateTime dt = DateTime.now();
    String ft = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dt);

    Map<String, dynamic> body = {
      "latitude": currentLat.value,
      "longitude": currentLng.value,
    };
    ResponseData response = await NetworkCaller().patchRequest(
      AppUrls.update_location,
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint(" location upload sucessfull");
    } else {
      debugPrint("location upload is error");
    }

    response = await NetworkCaller().getRequest(
      "https://salahmarhaba.com/api/v1/auth/next-prayer-times?now=${ft}",
    );

    if (response.statusCode == 200) {
      debugPrint("date and location upload sucessfull");
      salahTime.value =
          " ${response.responseData["name"]}: ${response.responseData["time"]}";
    } else {
      debugPrint("date and location upload is error");
    }
  }
}
