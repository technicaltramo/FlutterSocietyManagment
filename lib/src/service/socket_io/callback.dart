abstract class  SocketCallback {
  onMessageReceive(data);
  onUserOnline(bool isOnline,dynamic data);
  onTyping(dynamic data);
  onSocketConnect(data);
}

