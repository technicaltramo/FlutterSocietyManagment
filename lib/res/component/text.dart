import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/widget.dart';

appAppBar({String title,IconData icon, Function onPress}){
  return AppBar(
    actions: [
      PopupMenuButton<String>(

        itemBuilder: (BuildContext context) {
          return {'List View', 'Page View'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    ],
    title: Text(
      title,
      style: TextStyle(fontSize: 22),
    ),
  );
}


class AppTitleText1 extends StatelessWidget {
  final String title;
  final bool search;
  AppTitleText1({@required this.title,this.search = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [

      ],
      title: Text(
        title,
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}

class AppTitleText2 extends StatelessWidget {
  final String title;

  AppTitleText2({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Text(
        title,
        style:
            Theme.of(context).textTheme.headline5.copyWith(color: Colors.black),
      ),
    );
  }
}
