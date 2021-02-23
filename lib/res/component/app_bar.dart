import 'dart:async';

import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  final Function onSearchTextChanged;
  final String searchTitle;

  AppSearchBar(this.onSearchTextChanged, {this.searchTitle = "Search"});

  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  Timer _debounceTimer;
  var controller = TextEditingController();
  String preValue = "";

  @override
  void dispose() {
    controller.text = "";
    _debounceTimer?.cancel();
    super.dispose();
  }

  deBounce(Function onDebounce) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      onDebounce();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search,size: 32,),
          title: new TextField(
            style: TextStyle(
              fontSize: 22
            ),
            //textInputAction: TextInputAction.search,
            controller: controller,
            decoration: new InputDecoration(
              hintStyle: TextStyle(
                fontSize: 22
              ),
                hintText: widget.searchTitle, border: InputBorder.none),
            onChanged: (value) {
              String searchValue = value.trim();

              deBounce(() {
                if (searchValue != preValue) {
                  preValue = searchValue;
                  widget.onSearchTextChanged(searchValue);
                }
              });
            },
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel,size: 32,),
            onPressed: () {
              controller.clear();
              widget.onSearchTextChanged("");
            },
          ),
        ),
      ),
    );
  }
}
