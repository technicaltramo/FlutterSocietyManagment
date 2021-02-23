import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/res/icons.dart';
import 'package:t_society/src/presentation/bill_payment/bill_type/controller.dart';


class SelectBillTypeScreen extends GetView<BillTypeController> {
  @override
  Widget build(BuildContext context) {
    Get.put(BillTypeController(context));
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             AppTitleText1(title: "Select Bill",),
              Row(children: <Widget>[
                _BuildItem(BillType.ELECTRICITY),
                _BuildItem(BillType.BROADBAND),
                _BuildItem(BillType.WATER),
              ],),
              Row(children: <Widget>[
                _BuildItem(BillType.INSURANCE),
                _BuildItem(BillType.POSTPAID),
                _BuildItem(BillType.GAS),
              ],),
              Row(children: <Widget>[
                _BuildItem(BillType.LANDLINE),
                _BuildItem(BillType.BROADBAND,visibility: false,),
                _BuildItem(BillType.BROADBAND,visibility: false,),
              ],),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildItem extends GetView<BillTypeController>{

  final BillType billType;
  final bool visibility;

  _BuildItem(this.billType,{this.visibility = true});

  @override
  Widget build(BuildContext context) {

    var mBill = getBillIconAndTitle(billType);

    var title = mBill["title"];
    var icon = mBill["icon"];
    var color = mBill["color"];

    return Expanded(
      flex: 1,
      child: Visibility(
        visible: visibility,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: ()=>controller.onBillSelect(billType),
          child: Container(
            height: 140,
            child: Card(
              elevation: 1,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(icon,height: 72,width: 72,color: color,),
                    Text(title,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: color),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

