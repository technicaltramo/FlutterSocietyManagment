import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:t_society/res/component/app_bar.dart';
import 'package:t_society/src/model/complain.dart';
import 'package:t_society/src/presentation/complain/complain_list/update_dialog.dart';

import 'controller.dart';

class BuildComplainListBody extends GetView<ComplainListController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: 60),
        height: Get.height,
        width: Get.width,
        child: _buildContent(),
      ),
    );
  }

  _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Obx(() {
          var filterValue = controller.filterInputObs.value;
          var searchHint;
          var searchType;
          if (filterValue == ComplainFilterInput.BY_COMPLAIN_NAME) {
            searchHint = "Search By Complain Title";
            searchType = "complainTitle";
          }
          if (filterValue == ComplainFilterInput.USERNAME) {
            searchHint = "Search By User Name";
            searchType = "username";
          }
          if (filterValue == ComplainFilterInput.FLAT_NO) {
            searchHint = "Search By Flat No.";
            searchType = "flatNo";
          }
          if (filterValue == ComplainFilterInput.EMAIL) {
            searchHint = "Search By Email";
            searchType = "email";
          }
          else  {
            searchHint = "Search By Mobile";
            searchType = "mobile";
          }

          return AppSearchBar(
                (value){
              onSearchTextChanged(value,searchType);
            },
            searchTitle: searchHint,
          );
        }),
        Expanded(
          child: PagedListView<int, Complain>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Complain>(
              itemBuilder: (context, item, index) =>
                  _buildComplainCardItem(item),
            ),
          ),
        )
      ],
    );
  }

  void onSearchTextChanged(String value,String searchType) {
    controller.paginationPageKey = 1;
    controller.query = {
      "searchType" : searchType,
      "searchValue" : value
    };
    controller.paginationPageKey = 1;
    controller.pagingController.refresh();
  }

  _buildComplainCardItem(Complain complain) {
    Color statusColor = (complain.status == 1)
        ? Colors.green
        : (complain.status == 2)
        ? Colors.red
        : Colors.blue[600];
    String status = (complain.status == 1)
        ? "Success"
        : (complain.status == 2)
        ? "Failed"
        : "Pending";

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        showDialog(
            context: controller.context,
            useRootNavigator: true,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return ComplainConfirmDialog(complain);
            }).then((value) {
          if (value != null) {
            controller.updateComplainStatus(complain.sId, value);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              foregroundColor: Colors.white,
              backgroundColor: statusColor,
              child: Icon(
                Icons.comment,
                size: 32,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${complain.name}",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Priority - ${complain.priority}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "From - ${complain.fromUser.name} - ${complain.fromUser.flatNo}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  status,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: statusColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}