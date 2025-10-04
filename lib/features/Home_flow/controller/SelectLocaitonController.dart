import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:jamayate_namaj/core/helper/shared_preference_helper.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/group_chat_request_screen.dart';

import '../../../core/service_class/network_caller/model/network_response.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/utils/app_urls.dart'; // Add the package to your pubspec.yaml

class LocationController extends GetxController {
  // Variables for location
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  TextEditingController locationController = TextEditingController();

  RxString locatonString = "".obs;

  RxSet<Marker> markers = <Marker>{}.obs;
  GoogleMapController? mapController;

  void addMarker() {
    markers.add(
      Marker(
        markerId: MarkerId('target_location'),
        position: LatLng(lat.value, lng.value),
        infoWindow: InfoWindow(title: 'Current Location'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  void addMarkers(String locDetails) {
    markers.add(
      Marker(
        markerId: MarkerId('target_location'),
        position: LatLng(lat.value, lng.value),
        infoWindow: InfoWindow(title: '$locDetails'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }

  void getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemark = await GeocodingPlatform.instance!
          .placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemark[0];
      locatonString.value =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
      debugPrint("location name= " + locatonString.value);
    } catch (e) {
      // Handle errors (network issues, invalid coordinates, etc.)
      debugPrint('Error: $e');
      locatonString.value = "";
    }
  }

  RxString title = "".obs;
  String time = "";
  RxBool isLoading = false.obs;

  createAdvertisement() async {
    isLoading.value = true;
    int times = int.parse(time);
    SharedPreferencesHelper prefs = SharedPreferencesHelper();
    Map<String, dynamic> body = {
      "title": title.value,
      "endAt": times,
      "latitude": lat.value,
      "longitude": lng.value,
    };
    try {
      isLoading.value = true;
      ResponseData response = await NetworkCaller().postRequest(
        AppUrls.create_advertising,
        body: body,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Tell People To Join Jama'at Successfully",
          colorText: Colors.green,
        );

        String creator_uid = response.responseData["userId"];
        String creator_jid = response.responseData["id"];

        debugPrint("creator _uid" + creator_uid);
        debugPrint("creator _jid" + creator_jid);

        prefs.setString("creator_uid", creator_uid);
        prefs.setString("creator_jid", creator_jid);

        Get.to(
          () => GroupChatRequestScreen(
            creator_uid,
            creator_jid,
            lat.value,
            lng.value,
          ),
        );
      } else if (response.statusCode == 400) {
        Get.snackbar(
          "Error",
          "You already tell people for Jama'at",
          colorText: Colors.red,
          backgroundColor: Colors.black,
        );

        String? creator_uid = prefs.getString("creator_uid");
        String? creator_jid = prefs.getString("creator_jid");

        debugPrint("creator _uid" + creator_uid.toString());
        debugPrint("creator _jid" + creator_jid.toString());

        Get.to(
          () => GroupChatRequestScreen(
            creator_uid!,
            creator_jid!,
            lat.value,
            lng.value,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    isLoading.value = false;
  }





}
