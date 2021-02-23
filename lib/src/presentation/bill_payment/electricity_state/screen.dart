import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/api.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/model/bill.dart';
import 'package:t_society/src/model/response/bill.dart';
import 'package:t_society/util/api_resource/api_result.dart';

import 'controller.dart';

class BillElectricityStateScreen extends GetView<BillElectricityStateController> {


  @override
  Widget build(BuildContext context) {
    Get.put(BillElectricityStateController());

    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          ApiResult result = controller.listElectricityStateObs.value;
          return result.when(fetched: (data) {
            ElectricityStateListResponse response = data;
            if (response.status == 1) {
              controller.listState = response.stateNames;
              if (controller.listState.length > 0) {
                return _buildScreenBody();
              } else
                return ApiNoDataFound();
            } else
              return ApiSomethingWentWrong();
          }, init: () {
            return ApiProgress();
          });
        }),
      ),
    );
  }

  Widget _buildScreenBody(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppTitleText1(title: "Select State",),
        Expanded(
          child: _BuildProviderListView(),
        )
      ],
    );
  }
}

class _BuildProviderListView extends GetView<BillElectricityStateController> {
  @override
  Widget build(BuildContext context) {
    var listState = controller.listState;
    var count = listState.length;

    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: count,
      itemBuilder: (context, index) {
        StateName stateName = listState[index];
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: ()=>controller.onListItemClick(stateName.stateName),
          child: Container(
            padding: EdgeInsets.only(bottom: (index == 49) ? 100 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    stateName.stateName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                BuildHorizontalLine()
              ],
            ),
          ),
        );
        ;
      },
    );
  }
}
