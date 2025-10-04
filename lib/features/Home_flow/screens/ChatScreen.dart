import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamayate_namaj/core/app_route/app_route.dart';
import 'package:jamayate_namaj/core/helper/shared_preference_helper.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/group_chat_request_screen.dart';
import 'package:jamayate_namaj/features/Home_flow/screens/home_screen.dart';
import '../controller/chatController.dart';
import 'Routing_location.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String jamaatId;
  bool? ishome;

  ChatScreen({
    super.key,
    required this.userId,
    required this.jamaatId,
    this.ishome,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    chatController.connect(widget.jamaatId, widget.userId);
    chatController.getCurrentLocation();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    chatController.close();
    super.dispose();
  }

  void sendMessage() {
    String text = messageController.text.trim();
    if (text.isNotEmpty) {
      chatController.sendMessage(message: text);
      messageController.clear();
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper sp = SharedPreferencesHelper();
    bool? isadvertiser = sp.getBool("isAdvertiser");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chat", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        leading:
            isadvertiser == true
                ? InkWell(
                  onTap: () {
                    if (widget.ishome == false) {
                      Get.back();
                    } else {
                      Get.to(
                        () => GroupChatRequestScreen(
                          widget.userId,
                          widget.jamaatId,
                          chatController.lat.value,
                          chatController.lng.value,
                        ),
                      );
                    }
                  },

                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30.r,
                  ),
                )
                : SizedBox(),
        actions: [
          isadvertiser == false
              ? InkWell(
                onTap: () {
                  chatController.leavefunction();
                  Get.offAllNamed(AppRoute.splashScreen);
                },
                child: Container(
                  height: 30.h,
                  width: 60.w,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.red.withOpacity(0.80),
                  ),
                  child: Center(
                    child: Text(
                      "Leave",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ),
                ),
              )
              : SizedBox(),

          SizedBox(width: 8.w),
          InkWell(
            onTap: () {
              Get.to(() => RoutingLocation());
            },
            child: Container(
              height: 30.h,
              width: 90.w,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  "Location",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ChatController>(
              // Ensure GetX UI update
              builder: (controller) {
                return ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: controller.messages.length,
                  controller: _scrollController,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    bool isSentByMe = message['senderId'] == widget.userId;
                    String userName = message["usernames"] ?? "";

                    if (userName.length > 10) {
                      userName = userName.substring(0, 10) + '..';
                    } else {
                      userName = userName;
                    }

                    debugPrint("my user Name============" + userName);

                    return Align(
                      alignment:
                          isSentByMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child:
                          isSentByMe
                              ? Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      isSentByMe
                                          ? Colors.blueAccent
                                          : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  message["message"] ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        isSentByMe
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              )
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color:
                                              isSentByMe
                                                  ? Colors.blueAccent
                                                  : Colors.grey[300],
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          message["message"] ?? "",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                isSentByMe
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                    );
                  },
                );
              },
            ),
          ),

          Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onFieldSubmitted: (_) => sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: sendMessage,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    radius: 24,
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
