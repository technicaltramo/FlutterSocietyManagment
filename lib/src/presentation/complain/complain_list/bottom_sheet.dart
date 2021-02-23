import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'controller.dart';

class BottomSheetWidget extends GetView<ComplainListController> {
  final ScrollController sc;
  BottomSheetWidget(this.sc);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          controller: sc,
          children: <Widget>[
            _buildHeader(),
            _buildStatusFilterOption(),
          ],
        ));
  }

  _buildStatusFilterOption() => Column(
    children: [
      Text(
        "Status Filter",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
      ),
      Container(
        margin: EdgeInsets.only(left: 32, right: 8, top: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _buildStatusFilterRadio(ComplainFilterStatus.ALL),
            _buildStatusFilterRadio(ComplainFilterStatus.SUCCESS),
            _buildStatusFilterRadio(ComplainFilterStatus.FAILED),
            _buildStatusFilterRadio(ComplainFilterStatus.PENDING),
          ],
        ),
      ),
      SizedBox(
        height: 32,
      ),
      Text(
        "Input Filter",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
      ),
      Container(
        margin: EdgeInsets.only(left: 32, right: 8, top: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _buildInputFilterRadio(ComplainFilterInput.BY_COMPLAIN_NAME),
            _buildInputFilterRadio(ComplainFilterInput.USERNAME),
            _buildInputFilterRadio(ComplainFilterInput.FLAT_NO),
            _buildInputFilterRadio(ComplainFilterInput.MOBILE),
            _buildInputFilterRadio(ComplainFilterInput.EMAIL),
          ],
        ),
      )
    ],
    crossAxisAlignment: CrossAxisAlignment.start,
  );

  _buildHeader() => Column(
    children: [
      SizedBox(
        height: 12.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
          ),
        ],
      ),
      SizedBox(
        height: 8.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.filter_alt_rounded,
            size: 28,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Filter By",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 16.0,
      ),
    ],
  );

  _buildStatusFilterRadio(ComplainFilterStatus filterStatus) {
    String title;
    var color;
    if (filterStatus == ComplainFilterStatus.ALL) {
      title = "All Complains";
      color = Colors.black;
    } else if (filterStatus == ComplainFilterStatus.SUCCESS) {
      color = Colors.green;
      title = "Success Complains";
    } else if (filterStatus == ComplainFilterStatus.FAILED) {
      color = Colors.red;
      title = "Failed Complains";
    } else {
      title = "Pending Complains";
      color = Colors.blue;
    }

    return Row(
      children: [
        Radio(
            value: filterStatus,
            groupValue: controller.filterStatusObs.value,
            onChanged: (value) {
              controller.filterStatusObs.value = value;
              controller.onComplainStatusChange(value);
            }),
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: color),
        )
      ],
    );
  }

  _buildInputFilterRadio(ComplainFilterInput filterStatus) {
    String title;
    var color;
    if (filterStatus == ComplainFilterInput.BY_COMPLAIN_NAME)
      title = "By Complain Title";
    else if (filterStatus == ComplainFilterInput.USERNAME)
      title = "By User Name";
    else if (filterStatus == ComplainFilterInput.FLAT_NO)
      title = "By Flat Number";
    else if (filterStatus == ComplainFilterInput.MOBILE)
      title = "By Mobile Number";
    else
      title = "By Email ID";

    return Row(
      children: [
        Radio(
            value: filterStatus,
            groupValue: controller.filterInputObs.value,
            onChanged: (value) {
              controller.filterInputObs.value = value;
            }),
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: color),
        )
      ],
    );
  }
}