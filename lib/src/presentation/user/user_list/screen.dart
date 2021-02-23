import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:t_society/res/component/app_bar.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/presentation/user/user_detail_register/screen.dart';
import 'package:t_society/src/presentation/user/user_list/controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  UserListController controller;

  final double _initFabHeight = 85.0;
  double fabHeight;
  double panelHeightOpen;
  double panelHeightClosed = 60.0;

  @override
  void initState() {
    fabHeight = _initFabHeight;
    controller = Get.put(UserListController(context));
    controller.fetchUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    panelHeightOpen = MediaQuery.of(context).size.height * .50;

    return Material(
      child: Stack(
        children: [
          SlidingUpPanel(
            maxHeight: panelHeightOpen,
            minHeight: panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            panelBuilder: (sc) => _BottomSheetWidget(sc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              fabHeight =
                  pos * (panelHeightOpen - panelHeightClosed) + _initFabHeight;
            }),
            body: _BuildBody(),
          ),
          Positioned(
              top: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.transparent,
                      )))),
          Positioned(
            right: 20.0,
            bottom: fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () => Get.to(UserRegisterScreen(null)),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildBody extends GetView<UserListController> {
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

  _buildContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Obx(() {
            var filterValue = controller.searchFilterValue.value;
            var searchHint;
            var searchType;
            if (filterValue == FilterRadioValue.NAME) {
              searchHint = "Search By Name";
              searchType = "name";
            }
            if (filterValue == FilterRadioValue.MOBILE) {
              searchHint = "Search By Mobile";
              searchType = "mobile";
            }
            if (filterValue == FilterRadioValue.FLAT) {
              searchHint = "Search By Flat No.";
              searchType = "flatNo";
            }
            if (filterValue == FilterRadioValue.EMAIL) {
              searchHint = "Search By Email";
              searchType = "email";
            }

            return AppSearchBar(
              (value){
                onSearchTextChanged(value,searchType);
              },
              searchTitle: searchHint,
            );
          }),
          Expanded(
            child: PagedListView<int, User>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<User>(
                itemBuilder: (context, item, index) => _buildListCard(item),
              ),
            ),
          )
        ],
      );

  void onSearchTextChanged(String value,String searchType) {
    controller.paginationPageKey = 1;
    controller.query = {
      "searchType" : searchType,
      "searchValue" : value
    };
    controller.paginationPageKey = 1;
    controller.pagingController.refresh();
  }

  _buildListCard(User user) {
    var cardTitle = Theme.of(controller.context)
        .textTheme
        .headline6
        .copyWith(fontSize: 18, letterSpacing: 1.1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Get.to(UserRegisterScreen(user)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Theme.of(controller.context).primaryColor,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${user.name}",
                          style: cardTitle,
                        ),
                        AppWidget.height(value: 4),
                        Text(
                          "flat : ${user.flatNo}",
                        ),
                        Text(
                          "mobile : ${user.mobile}",
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      (user.active)
                          ? Text(
                              "Active",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500),
                            )
                          : Text(
                              "Inactive",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheetWidget extends GetView<UserListController> {
  final ScrollController sc;

  _BottomSheetWidget(this.sc);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Column(
                children: [
                  _buildRadioButton(FilterRadioValue.NAME),
                  _buildRadioButton(FilterRadioValue.MOBILE),
                  _buildRadioButton(FilterRadioValue.FLAT),
                  _buildRadioButton(FilterRadioValue.EMAIL),
                ],
              ),
            ),
          ],
        ));
  }

  _buildRadioButton(FilterRadioValue filterRadioValue) {
    String title;
    if (filterRadioValue == FilterRadioValue.NAME)
      title = "User Name";
    else if (filterRadioValue == FilterRadioValue.MOBILE)
      title = "Mobile Number";
    else if (filterRadioValue == FilterRadioValue.FLAT)
      title = "Flat Number";
    else
      title = "Email ID";

    return ListTile(
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
      leading: Radio(
        value: filterRadioValue,
        groupValue: controller.searchFilterValue.value,
        onChanged: (FilterRadioValue value) {
          controller.searchFilterValue.value = value;
        },
      ),
    );
  }
}
