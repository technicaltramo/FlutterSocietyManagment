import 'package:t_society/res/string.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/src/service/socket_io/callback.dart';
import 'package:t_society/src/service/socket_io/event.dart';
import 'package:t_society/util/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {

  static AppPreference appPreference = sl.get();

  static String TAG = "SocketService";
  static IO.Socket socketIO;
  static SocketCallback _socketCallback;

  static void setUpSocketServiceCallback(SocketCallback e)
   => _socketCallback = e;



  static Future<void> connectSocket() async {

    var socketOption = <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {"userId": appPreference.user.sId}
    };
    socketIO = IO.io(AppString.BASE_URL, socketOption);
    socketIO.connect();
    socketIO.on(SocketEvent.CONNECT_EVENT, onConnectionEstablished);
  }

  static void onConnectionEstablished(data) {
    Utils.printLog("onConnectionEstablished",tag: TAG);

    _socketCallback.onSocketConnect(data);

    //on user disconnect
    socketIO.on(SocketEvent.DISCONNECT_EVENT, (data){
      Utils.printLog("onDisconnected");
    });
    socketIO.on("user_disconnect", (data) {
      Utils.printLog("user_disconnect");
    });

    socketIO.on(SocketEvent.RECEIVE_MESSAGE,_onReceiveMessage);
    socketIO.on(SocketEvent.ONLINE_USER,_onUserOnline);
    socketIO.on(SocketEvent.TYPING_EVENT, _onTyping);



  }


  // ON SOCKET
  static void _onReceiveMessage(data){
    Utils.printLog("onReceiveMessage",tag: TAG);
    _socketCallback.onMessageReceive(data);
  }

  static _onTyping(data){
    Utils.printLog("onTyping",tag: TAG);

    _socketCallback.onTyping(data);
  }

  static void _onUserOnline(data){
    Utils.printLog("onUserOnline",tag: TAG);
    _socketCallback.onUserOnline(true,data);
  }


  //EMIT SOCKET
  static void emitTyping(bool isTyping){
    Utils.printLog("inTyping",tag: TAG);

    socketIO.emit(SocketEvent.TYPING_EVENT,{
      "userId" : appPreference.user.sId,
      "isTyping" : isTyping,
    });

  }
  static void sendMessage(Map<String, dynamic> data) {
    Utils.printLog("onSendMessage",tag: TAG);

    socketIO.emit(SocketEvent.SEND_MESSAGE, data);
  }


}


