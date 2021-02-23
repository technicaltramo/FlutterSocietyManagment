import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/image.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/src/model/response/user.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/presentation/message/message_screen.dart';
import 'package:t_society/src/presentation/user/user_list/controller.dart';
import 'package:t_society/util/api_resource/api_result.dart';

// ignore: must_be_immutable
class ChatUserListScreen extends GetView<UserListController> {


  @override
  Widget build(BuildContext context) {
     Get.put(UserListController(context));
     controller.fetchUserList();
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Obx(() {
            ApiResult apiResult = controller.userListObs.value;
            return apiResult.when(fetched: (data) {
              UserListResponse response  = data;
              List<User> userList = response.users;


              if (userList.length > 0)
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  //  AppText.largeTitle("Chat"),
                    AppTitleText1(title: "Chat",),
                    Expanded(
                      child: ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return _buildListCard(userList[index]);
                          }),
                    )
                  ],
                );
              else
                return Center(
                  child: Text("No user found for message"),
                );
            }, init: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            });
          }),
        ),
      ),
    );
  }

  _buildListCard(User user, {bool isLastItem = false}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        Get.to(MessageScreen(user.sId));
      },
      child: Card(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.cyan,
                    child: Image.asset(AppImage.userIcon),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text(
                         "${user.name}",
                         style: AppTextStyle.cardH2(),
                       ),
                       SizedBox(height: 4,),
                       Text(
                         "${user.flatNo} - ${user.mobile}",
                         style: AppTextStyle.text2(),
                       ),
                     ],
                    ),
                  ),
                  Spacer(),
                  (user.active) ?  Text(
                    "Online",
                    style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),
                  ) :  Text(
                    "Offline",
                    style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Container(
                height: 1,
                color: Colors.grey[200],
              )
            ],
          ),
        ),
      ),
    );
  }
}
