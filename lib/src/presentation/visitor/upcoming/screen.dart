import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/string.dart';
import 'package:t_society/src/model/visitor.dart';
import 'package:t_society/src/presentation/visitor/upcoming/controller.dart';

class UpcomingVisitorScreen extends GetView<UpcomingVisitorController> {

  final VisitorInfo visitor;
  UpcomingVisitorScreen(this.visitor);

  @override
  Widget build(BuildContext context) {

    var h6TStyle = Theme.of(context).textTheme.headline4.copyWith(color: Colors.black87,fontSize: 28);
    var h6TStyle2 = Theme.of(context).textTheme.headline4.copyWith(fontSize: 22);


    Get.put(UpcomingVisitorController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        color: Colors.white30,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        width: 190.0,
                        height: 190.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    AppString.BASE_URL+visitor.picUrl)
                            )
                        )),
                    SizedBox(height: 16,),
                    Text(visitor.name,style: h6TStyle),
                    SizedBox(height: 8,),
                    Text(visitor.name,style: h6TStyle2),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.cancel,
                  size: 120,
                  color: Colors.red,
                ),
                Spacer(),
                Icon(
                  Icons.check_circle,
                  size: 120,
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
