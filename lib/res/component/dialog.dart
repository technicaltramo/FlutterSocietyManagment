import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:t_society/res/component/button.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/text_field.dart';

class AppDialog {
  static Future<void> showLoaderDialog(BuildContext context) {
    Widget alert = WillPopScope(
      onWillPop: () async => true,
      child: AlertDialog(
        content: new Row(
          children: [
            CircularProgressIndicator(),
            Container(margin: EdgeInsets.only(left: 7), child: Text("Login")),
          ],
        ),
      ),
    );
    return showDialog(
      useRootNavigator: true,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static squareTransparentProgress(BuildContext context,
      {String title = "Loading..."}) {
    showDialog(
        useRootNavigator: true,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            _squareTransparentProgressBuilder(title));
  }

  static _squareTransparentProgressBuilder(title) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(0),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black54),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }


  static Future<String> sendNotificationDialog(BuildContext context,String title){
    String message = "Payment reminder for this month. Please pay without any delay. Thank-you";
    return showDialog(
        useRootNavigator: true,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            _sendNotificationDialogBuilder(message,title));
  }

  static _sendNotificationDialogBuilder(message,title) {
    final textController = TextEditingController();
    textController.text = message;
    return WillPopScope(
      onWillPop: () async => true,
      child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,

          child: Stack(
            overflow: Overflow.visible,
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 60),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    AppTitleText2(title: title,),
                    //AppText.mediumTitle(title),

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                      ),
                      child: TextField(
                        controller: textController,
                        maxLines: 8,
                        decoration: InputDecoration.collapsed(hintText: "Message"),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: -30,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    String text = textController.text;
                    if(text.isNotEmpty){
                      Get.back(result: text);
                    }
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Transform.rotate(
                      angle: 5.7,
                        child: Icon(Icons.send)),
                  ),
                ),
              )
            ],
          )),
    );
  }

}
