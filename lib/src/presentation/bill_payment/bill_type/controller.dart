import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/icons.dart';
import 'package:t_society/src/presentation/bill_payment/electricity_state/screen.dart';
import 'package:t_society/src/presentation/bill_payment/provider/screen.dart';

class BillTypeController extends GetxController {
  final BuildContext context;

  BillTypeController(this.context);

  void onBillSelect(BillType billType) {
    if (billType == BillType.ELECTRICITY)
      Get.to(BillElectricityStateScreen());
    else
      Get.to(BillProviderScreen(billType));
  }
}

enum BillType {
  ELECTRICITY,
  BROADBAND,
  WATER,
  INSURANCE,
  POSTPAID,
  GAS,
  LANDLINE,
}

Map getBillIconAndTitle(BillType type) {
  var strBill = "";
  var icon = "";
  var color = Colors.white;
  switch (type) {
    case BillType.ELECTRICITY:
      strBill = "ELECTRICITY";
      icon = AppICon.ELECTRICITY;
      color = Colors.red;
      break;
    case BillType.BROADBAND:
      strBill = "BROADBAND";
      icon = AppICon.BROADBAND;
      color = Colors.blueGrey;
      break;
    case BillType.WATER:
      strBill = "WATER";
      icon = AppICon.WATER;
      color = Colors.blue;
      break;
    case BillType.INSURANCE:
      strBill = "INSURANCE";
      icon = AppICon.INSURANCE;
      color = Colors.purple;
      break;
    case BillType.POSTPAID:
      strBill = "POSTPAID";
      icon = AppICon.MOBILE;
      color = Colors.teal;
      break;
    case BillType.GAS:
      strBill = "GAS";
      icon = AppICon.GAS;
      color = Colors.red;
      break;
    case BillType.LANDLINE:
      strBill = "LANDLINE";
      icon = AppICon.BROADBAND;
      color = Colors.blueGrey;
      break;
  }
  ;
  var mMap = Map<String, dynamic>();
  mMap['title'] = strBill;
  mMap['icon'] = icon;
  mMap['color'] = color;
  return mMap;
}
