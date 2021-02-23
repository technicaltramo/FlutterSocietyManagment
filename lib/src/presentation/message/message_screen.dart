import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/custom/chat_buble.dart';
import 'package:t_society/res/image.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/model/message.dart';
import 'package:t_society/src/presentation/message/message_controller.dart';
import 'package:t_society/util/utils.dart';

// ignore: must_be_immutable
class MessageScreen extends GetView<MessageController> {

  final String toUserId;
  int currentIndex = 0;
  MessageScreen(this.toUserId);

  @override
  Widget build(BuildContext context) {
    Get.put(MessageController(toUserId,context));
    controller.isKeyboardOpenObs.value = Utils.keyboardIsVisible(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Row(
            children: <Widget>[
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset(
                  AppImage.userIcon,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(toUserId),
                    Obx((){
                      TypingInfo typingInfo = controller.typingInfoObs.value;
                        if(typingInfo.isTyping != null){
                          return Text(
                            typingInfo.isTyping ? ((typingInfo.typingUser == toUserId) ? "typing..." : "online") : "online" ,
                            style: TextStyle(fontSize: 12),
                          );
                        }
                        else {
                          return Text(
                            "online" ,
                            style: TextStyle(fontSize: 12),
                          );
                        }
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: _ChatView(),
      ),
    );
  }
}

class _ChatView extends StatelessWidget {

  MessageController controller = Get.find<MessageController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            child: Obx(() {
              bool isConnect = controller.isSocketConnect.value;
              return (isConnect)
                  ? Obx(() {
                      List<Message> messages = controller.messageListObs.value;
                      AppPreference appPref = controller.appPreference;
                       if (messages.length > 0)
                          {
                            controller.scrollToBottom();
                            return ListView.builder(
                                controller: controller.scrollController,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  Message message = messages[index];

                                  if ((message.fromUser == appPref.user.sId)) {
                                    return _buildListItem(0, message);
                                  } else {
                                    return _buildListItem(1, message);
                                  }
                                });
                          }
                          else return Center(
                              child: Text("No Message found"),
                            );
                    })
                  : Center(
                      child: Text("Connecting..."),
                    );
            }),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white70),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller.textController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Hi..",
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onPressed: () {
                  controller.sendMessage();
                },
              )
            ],
          ),
        )
      ],
    );
  }

  _buildListItem(int type, Message message) {
    return Align(
      alignment: (type == 0) ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(
            top: 8,
            right: (type == 0) ? 30 : 8,
            bottom: 8,
            left: (type == 1) ? 30 : 8),
        child: Align(
          alignment: (type == 0) ? Alignment.topLeft : Alignment.topRight,
          child: (type == 0)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _buildUserIcon(type),
                    _buildUserMessage(type, message)
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _buildUserMessage(type, message),
                    _buildUserIcon(type),
                  ],
                ),
        ),
      ),
    );
  }

  _buildUserIcon(int type) {
    return CircleAvatar(
        backgroundColor: (type == 1) ? Colors.blueGrey : Colors.green,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ));
  }

  _buildUserMessage(int type, Message message) {
    return Flexible(
      flex: 1,
      child: CustomPaint(
        painter: ChatBubble(
            color: (type == 0) ? Colors.green : Colors.blueGrey,
            alignment: (type == 0) ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment:
                (type == 0) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "Admin",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white),
              ),
              Text(
                "Akash kumar Das",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  message.content,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
