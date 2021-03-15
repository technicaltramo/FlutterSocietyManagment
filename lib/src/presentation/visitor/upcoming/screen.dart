import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_society/res/string.dart';
import 'package:t_society/src/model/visitor.dart';
import 'package:t_society/src/presentation/visitor/upcoming/controller.dart';

class UpcomingVisitorScreen extends GetView<UpcomingVisitorController> {
  final Visitor visitor;

  UpcomingVisitorScreen(this.visitor);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Get.put(UpcomingVisitorController(context,visitor));
    var width = MediaQuery.of(context).size.width;
    var visitorPicWidth = width * 0.75;

    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
              0.1,
              0.5,
              0.9
            ],
                colors: [
              Colors.white12,
              Colors.white24,
              Colors.white30,
            ])),
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                Container(
                  width: Get.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Image.network(
                    AppString.BASE_URL + visitor.picUrl,
                    frameBuilder: (context, a, i, s) {
                      return a;
                    },
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: Get.width,
                    color: Colors.black54,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Visitor Request",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 8,
                    right: 8,
                    left: 8,
                    child: Card(
                      color: Colors.black45,
                      child: Container(
                        width: Get.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              visitor.visitorName,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            Text(
                              visitor.visitorMobile,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 60,
                                      child: FlatButton(
                                        onPressed: () {
                                          controller.onAcceptRejectVisitor(true);
                                        },
                                        child: Text("Accept",style: TextStyle(
                                          fontSize: 18
                                        ),),
                                        color: Colors.green,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 60,
                                      child: FlatButton(
                                        onPressed: () {
                                          controller.onAcceptRejectVisitor(false);
                                        },
                                        child: Text("Reject",style: TextStyle(
                                            fontSize: 18
                                        )),
                                        color: Colors.red,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
