import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutingLocationController extends GetxController{


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
  }
  RxDouble lat=0.0.obs;
  RxDouble lng=0.0.obs;
RxBool isLoading =false.obs;


RxSet<Marker> markers = <Marker>{}.obs; // Observable set of markers
GoogleMapController? mapController;

void _addMarker() {
  markers.add(
    Marker(
      markerId: MarkerId('target_location'),
      position: LatLng(lat.value, lng.value),
      infoWindow: InfoWindow(title: 'Current Location'),
      icon: BitmapDescriptor.defaultMarker,
    ),
  );
}
  getCurrentLocation()async{
    isLoading.value=true;
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat.value=position.latitude;
    lng.value=position.longitude;

    debugPrint("lat===========${lat.value}");
    debugPrint("lng===========${lng.value}");

_addMarker();
isLoading.value=false;
  }


}