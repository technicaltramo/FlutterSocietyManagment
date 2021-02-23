import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/api.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/model/bill.dart';
import 'package:t_society/src/model/response/bill.dart';
import 'package:t_society/src/presentation/bill_payment/bill_type/controller.dart';
import 'package:t_society/src/presentation/bill_payment/provider/controller.dart';
import 'package:t_society/util/api_resource/api_result.dart';

class BillProviderScreen extends GetView<BillProviderController> {
  final BillType billType;
  final String stateName;

  BillProviderScreen(this.billType,{this.stateName});

  @override
  Widget build(BuildContext context) {
    Get.put(BillProviderController(billType,stateName: stateName));
    
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          ApiResult result = controller.listProviderObs.value;
          return result.when(fetched: (data) {
            BillProviderResponse response = data;
            if (response.status == 1) {
              controller.providerList = response.providers;
              if (controller.providerList.length > 0) {
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
    var mBill = getBillIconAndTitle(billType);
    var title = mBill["title"];
    var icon = mBill["icon"];
    var color = mBill["color"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              icon,
              color: color,
              height: 72,
              width: 72,
            ),
            AppTitleText1(title: title,)
          ],
        ),
        Expanded(
          child: _BuildProviderListView(),
        )
      ],
    );
  }
}

class _BuildProviderListView extends GetView<BillProviderController> {
  @override
  Widget build(BuildContext context) {
    var providerList = controller.providerList;
    var count = providerList.length;
    var billType = controller.billType;

    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: count,
      itemBuilder: (context, index) {
        BillProvider provider = providerList[index];
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: ()=>controller.onProviderClick(provider),
          child: Container(
            padding: EdgeInsets.only(bottom: (index == 49) ? 100 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    provider.providerName,
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
