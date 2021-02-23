import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/presentation/base_screen.dart';
import 'package:t_society/src/presentation/dashboard/item_screen.dart';
import 'package:t_society/src/service/socket_io/service.dart';
import 'package:t_society/util/api_resource/api_result.dart';

import 'controller.dart';

// ignore: must_be_immutable
class DashboardScreen extends GetView<DashboardController> {
  SocketService service = SocketService();

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController(context));
    return BaseScreen(
      child: SafeArea(
        child: Scaffold(

          body: Stack(
            children: <Widget>[
              Container(
                width: Get.width,
                height: Get.height,
                child: Obx(() {
                  ApiResult apiResult = controller.connectionStateObs.value;
                  return apiResult.when(fetched: (data) {
                    Map<String, String> map = data;
                    String type = map['type'];
                    String message = map['message'];
                    if (type == "connected")
                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            _buildToolbar(context),
                            DashBoardItemScreen()
                          ],
                        ),
                      );
                    else
                      return Center(
                        child: Text(message),
                      );
                  }, init: () {
                    return Center(
                      child: Text("initiating..."),
                    );
                  });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildToolbar(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 8,),
                Text(
                  "Hi  User",
                  style: Theme.of(context).textTheme.headline6
                      .copyWith(color: Colors.white),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_active),
                  iconSize: 28,
                  color: Colors.white,
                )
              ],
            ),
            AppWidget.height(),
            Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${controller.appPreference.user.name}",
                      style: Theme.of(context).textTheme.headline6
                      .copyWith(color: Colors.white),
                    ),
                    AppWidget.height(value: 4),
                    Text(
                      "H No-310",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                _BuildAmountSection()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _BuildAmountSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Text(
            "₹",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.green),
          ),
          Text(
            " : ",
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            "50000.00",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
