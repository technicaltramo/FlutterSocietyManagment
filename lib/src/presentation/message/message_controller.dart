import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/model/message.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/src/service/socket_io/callback.dart';
import 'package:t_society/src/service/socket_io/service.dart';

class MessageController extends GetxController
    implements SocketCallback {
  ScrollController scrollController;
  AppPreference appPreference = sl.get();

  var typingInfoObs = TypingInfo.init().obs;
  var isKeyboardOpenObs = false.obs;
  var isSocketConnect = false.obs;
  var textController = TextEditingController();
  var messageListObs = List<Message>().obs;
  User loggedInUser;
  String toUserId;
  BuildContext context;

  MessageController(this.toUserId, this.context);

  @override
  void onInit() {
    scrollController = new ScrollController();
    initSocket();
    onChange();
    super.onInit();
  }

  void initSocket() async {

    loggedInUser = appPreference.user;
    SocketService.setUpSocketServiceCallback(this);
    if (SocketService.socketIO == null)
      await SocketService.connectSocket();
    else
      isSocketConnect.value = true;
  }

  void sendMessage() {
    String content = textController.text;
    if (content == "") return;

    Message message = Message(
        content: content,
        fromUser: loggedInUser.sId,
        toUser: toUserId,
        createdAt: "");
    messageListObs.add(message);
    SocketService.sendMessage({
      "content": content,
      "fromUser": loggedInUser.sId,
      "toUser": toUserId,
    });
    textController.text = "";
    scrollToBottom();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  onMessageReceive(data) {
    Message message = Message.fromJson(data);
    messageListObs.add(message);
    scrollToBottom();
  }

  @override
  onSocketConnect(data) {
    isSocketConnect.value = true;
  }


  @override
  onUserOnline(bool isOnline, dynamic data) {}

  void scrollToBottom() async {
    Timer(
      Duration(milliseconds: 100),
      () => scrollController.jumpTo(scrollController.position.maxScrollExtent),
    );
  }

  void onChange() {
    isKeyboardOpenObs.listen((value) {
      SocketService.emitTyping(value);
    });
  }

  @override
  onTyping(data) {
    typingInfoObs.value = TypingInfo(data['userId'], data['isTyping']);
  }

}

class TypingInfo {
  String typingUser;
  bool isTyping;

  TypingInfo(this.typingUser, this.isTyping);

  TypingInfo.init();
}
