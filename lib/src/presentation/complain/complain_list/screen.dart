import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/string.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/presentation/complain/complain_list/controller.dart';
import 'package:t_society/src/presentation/complain/new_complain/screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'body.dart';
import 'bottom_sheet.dart';

// ignore: must_be_immutable
class ComplainListScreen extends StatefulWidget {
  @override
  _ComplainListScreenState createState() => _ComplainListScreenState();
}

class _ComplainListScreenState extends State<ComplainListScreen> {
  ComplainListController controller;
  final double _initFabHeight = 85.0;
  double fabHeight;
  double panelHeightOpen;
  double panelHeightClosed = 60.0;

  @override
  void initState() {
    fabHeight = _initFabHeight;
    controller = Get.put(ComplainListController(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Material(
      child: Stack(
        children: [
          SlidingUpPanel(
            maxHeight: panelHeightOpen,
            minHeight: panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            panelBuilder: (sc) => BottomSheetWidget(sc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              fabHeight =
                  pos * (panelHeightOpen - panelHeightClosed) + _initFabHeight;
            }),
            body: BuildComplainListBody(),
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
          _buildFloatingActionButton(),
        ],
      ),
    );
  }

  _buildFloatingActionButton() {
    var role = controller.appPreference.user.role;
    return (role == AppString.ROLE_USER)
        ? Positioned(
            right: 20.0,
            bottom: fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () => Get.to(NewComplainScreen()),
              backgroundColor: Colors.white,
            ),
          )
        : Nothing();
  }
}




