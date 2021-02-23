import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/image.dart';
import 'package:t_society/res/string.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/presentation/bill_payment/index.dart';
import 'package:t_society/src/presentation/complain/complain_list/screen.dart';
import 'package:t_society/src/presentation/dashboard/controller.dart';
import 'package:t_society/src/presentation/expense/expense_current_month.dart';
import 'package:t_society/src/presentation/expense/expense_start_screen.dart';
import 'package:t_society/src/presentation/message/chat_user_list_screen.dart';
import 'package:t_society/src/presentation/message/message_screen.dart';
import 'package:t_society/src/presentation/user/user_list/screen.dart';
import 'package:t_society/src/presentation/visitor/society_user_list/society_user_list_screen.dart';

var isNotification = 0;

class DashBoardItemScreen extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: _buildItem(controller.loggedInUser.role));
  }

  _buildItem(String role) {
    return (role == "guard")
        ? Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCardItem("New Visitor", "", Icons.group, () {
                    Get.to(SocietyUserListScreen());
                  }),
                  _buildCardItem("", "", Icons.description, () {},
                      visibility: false),
                ],
              ),
            ],
          )
        : Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCardItem("Users", "All society users", Icons.group, () {
                    Get.to(UserListScreen());
                  }),
                  _buildCardItem(
                    "Complains",
                    "All complains",
                    Icons.description,
                    () {
                      Get.to(ComplainListScreen());
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCardItem(
                      "Messages", "Groups & Individual", Icons.message,
                      () async {
                    if (controller.loggedInUser.role == "user")
                      Get.to(MessageScreen(controller.loggedInUser.createdBy));
                    else
                      Get.to(ChatUserListScreen());
                  }),
                  _buildCardItem(
                      "Events", "Upcoming events", Icons.event, () {}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCardItem(
                      "Expenses",
                      (role == AppString.ROLE_USER)
                          ? "Payment History"
                          : "Manage/History",
                      Icons.hourglass_empty, () {
                   if(role == AppString.ROLE_USER)
                     Get.to(ExpenseCurrentMonthScreen());
                   else  Get.to( Get.to(ExpenseStartScreen()));
                  }, count: false),
                  _buildCardItem("Bill Payment", "", Icons.payment, () {
                    Get.to(BillInitialScreen());
                  }, count: false),
                ],
              )
            ],
          );
  }

  _buildCardItem(String title, String subTitle, IconData icon, Function onClick,
      {bool visibility = true, bool count = true}) {
    Color iconColor;
    LinearGradient cardColor;

    if (title == "Users") {
      iconColor = Colors.green;
      cardColor = LinearGradient(colors: [
        Colors.green[100],
        Colors.green[100],
        Colors.green[100],
      ]);
    } else if (title == "Complains") {
      iconColor = Colors.red;
      cardColor = LinearGradient(colors: [
        Colors.red[100],
        Colors.red[100],
        Colors.red[100],
      ]);
    } else if (title == "Messages") {
      iconColor = Colors.blue;
      cardColor = LinearGradient(colors: [
        Colors.blue[100],
        Colors.blue[100],
        Colors.blue[100],
      ]);
    } else if (title == "Events") {
      iconColor = Colors.purple;
      cardColor = LinearGradient(colors: [
        Colors.purple[100],
        Colors.purple[100],
        Colors.purple[100],
      ]);
    } else if (title == "Expenses") {
      iconColor = Colors.red;
      cardColor = LinearGradient(colors: [
        Colors.red[100],
        Colors.red[100],
        Colors.red[100],
      ]);
    } else {
      iconColor = Colors.blueGrey;
      cardColor = LinearGradient(colors: [
        Colors.blueGrey[100],
        Colors.blueGrey[100],
        Colors.blueGrey[100],
      ]);
    }

    return Expanded(
      flex: 1,
      child: (visibility)
          ? GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                onClick();
              },
              child: Card(
                child: Container(
                  //decoration: BoxDecoration(gradient: cardColor),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8),
                                child: (title == "Expenses"
                                    ? Image.asset(
                                        AppImage.expense,
                                        width: 60,
                                        height: 60,
                                      )
                                    : Icon(
                                        icon,
                                        size: 60,
                                        color: iconColor,
                                      )),
                              ),
                              Visibility(
                                visible: count,
                                child: Positioned(
                                  top: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            title,
                            style: Theme.of(controller.context)
                                .textTheme
                                .headline6,
                          ),
                          AppWidget.height(value: 4),
                          Text(
                            subTitle,
                            style: AppTextStyle.text2(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Nothing(),
    );
  }
}

void a() {
  String s1;
  var s = s1 ?? "";
}
