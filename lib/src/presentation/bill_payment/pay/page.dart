import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:t_society/res/component/button.dart';
import 'package:t_society/res/component/text_field.dart';
import 'package:t_society/src/model/bill.dart';
import 'package:t_society/src/presentation/bill_payment/bill_type/controller.dart';
import 'package:t_society/src/presentation/bill_payment/pay/controller.dart';

class BillPayScreen extends GetView<BillPayController> {
  final BillProvider provider;
  final BillType billType;

  BillPayScreen(this.provider, this.billType);

  @override
  Widget build(BuildContext context) {
    Get.put(BillPayController(provider));

    var color = getBillIconAndTitle(billType)["color"];
    var title = getBillIconAndTitle(billType)["title"];
    var icon = getBillIconAndTitle(billType)["icon"];
    var textStyleH2 = Theme.of(context).textTheme.headline4;
    var textStyleH5 = Theme.of(context).textTheme.bodyText1;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                width: Get.width,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(15))),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Pay",
                      style: textStyleH2.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      title + " Bill",
                      style: textStyleH5.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          icon,
                          color: color,
                          height: 60,
                          width: 60,
                        ))
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AppTextFormField(
                              labelText: "Bill Number",
                            ),
                            AppTextFormField(
                              labelText: "Mobile Number",
                              fieldType: TextFieldType.MOBILE,
                            ),
                            AppTextFormField(
                              labelText: "DOB",
                              fieldType: TextFieldType.DOB,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AppButton(
                              color: color,
                              buttonText: "Pay Bill",
                              padding: EdgeInsets.symmetric(horizontal: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
