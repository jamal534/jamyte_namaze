import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jamayate_namaj/features/Home_flow/controller/Routing_location_controller.dart';

class RoutingLocation extends StatelessWidget {
   RoutingLocation({super.key});

   RoutingLocationController controller=Get.put(RoutingLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(controller.lat.value, controller.lng.value),
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController googleMapController) {
          controller.mapController = googleMapController;
        },
        markers: controller.markers.value, // Reactive markers
      ),
    );
  }
}
