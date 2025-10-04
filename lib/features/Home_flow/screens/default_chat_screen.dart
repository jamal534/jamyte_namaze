import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamayate_namaj/core/helper/shared_preference_helper.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/ChatScreen.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/myRooms_screen.dart';

class DefaultChatScreen extends StatelessWidget {
  const DefaultChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper sp=SharedPreferencesHelper();
    bool? isadvertiser=sp.getBool("isAdvertiser");

String? user=sp.getString("uId");
   String? jamat=sp.getString("jId");


    if(isadvertiser==true){
      return ChatScreen(userId: user!, jamaatId: jamat!);
    }else if(isadvertiser==false){
      return MyroomsScreen();
    }else{
      return Scaffold(
        body: Center(child:  Text("No Chat List Found"),),
      );
    }
    
    
  }
}
