import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/api.dart';
import 'package:t_society/res/component/button.dart';
import 'package:t_society/res/component/dropdown.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/src/model/response/user.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/util/api_resource/api_result.dart';

import 'society_user_list_controller.dart';

// ignore: must_be_immutable
class SocietyUserListScreen extends GetView<SocietyUserListController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SocietyUserListController());
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          ApiResult result = controller.userListResultObs.value;
          return result.when(fetched: (data) {
            UserListResponse response = data;
            controller.userList = response.users;
            var mCount = response.users.length;
            if (response.status == 1) {
              if (mCount > 0) {
                return Column(
                  children: <Widget>[
                    _buildDropDownSection(),
                    _buildListSection(),
                    _buildButtonSection()
                  ],
                );
              } else
                return ApiNoDataFound();
            } else {
              return ApiSomethingWentWrong();
            }
          }, init: () {
            return ApiProgress();
          });
        }),
      ),
    );
  }

  AppButton _buildButtonSection() {
    return AppButton(
      onPress: () {},
      buttonText: "Submit",
    );
  }

  Expanded _buildListSection() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: controller.userList.length,
          itemBuilder: (context, index) {
            return _BuildUserItemBuilder(index);
          },
        ),
      ),
    );
  }

  Row _buildDropDownSection() {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppDropDown(
            dropdownList: controller.towerList,
            onValueChanged: (value) {},
            selectedValue: controller.towerList[0],
          ),
        ),
        Expanded(
          child: AppDropDown(
            dropdownList: controller.towerList,
            onValueChanged: (value) {},
            selectedValue: controller.towerList[0],
          ),
        ),
      ],
    );
  }
}

class _BuildUserItemBuilder extends GetView<SocietyUserListController> {
  final int index;
  _BuildUserItemBuilder(this.index);

  @override
  Widget build(BuildContext context) {
    final User user = controller.userList[index];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        controller.onNewVisitor(user);
      },
      child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          child: Row(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${user.name} - ${user.flatNo}",
                      style: AppTextStyle.cardH2(),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      "${user.mobile}",
                      style: AppTextStyle.text2(),
                    ),
                  ],
                ),
              ),
              Spacer(),
              CircleAvatar(
                backgroundColor: Colors.green,
                child: IconButton(
                  onPressed: () {

                  },
                  icon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        BuildHorizontalLine()
      ],),
    );
  }
}
