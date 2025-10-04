import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamayate_namaj/core/helper/shared_preference_helper.dart';
import 'package:jamayate_namaj/features/Home_flow/controller/myRoomsScreenController.dart';

class MyroomsScreen extends StatelessWidget {
  MyroomsScreen({super.key});

  final MyRoomsScreenController controller = Get.put(MyRoomsScreenController());

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("Chat List"), centerTitle: true),

      body: Obx(
        () => controller.isLoading.value?Center(child: CircularProgressIndicator(),):
            controller.responses == null
                ? Center(
                  child: Text(
                    "No Chat List Found",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : Padding(
                  padding:  EdgeInsets.all(12.r),
                  child: ListView.builder(
                                itemCount:controller
                    .responses
                    ?.responseData["rooms"].length,
                    itemBuilder: (BuildContext context, index) {
                      var named =
                          controller
                              .responses
                              ?.responseData["rooms"][index]["jamat"];
                      return InkWell(
                        onTap: ()async{

              SharedPreferencesHelper sp=await SharedPreferencesHelper();
              String? userID =sp.getString("myUserId");
controller.joinJamaAt(named['id'], userID!);

                        },
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.star,size: 40.r,),
                            title: Text("${named["title"]}"),
                            subtitle: Text("${named["endAt"]}"),

                          ),
                        ),
                      );
                    },
                  ),
                ),
      ),
    );
  }
}
