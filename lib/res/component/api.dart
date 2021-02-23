import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApiProgress extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ApiSomethingWentWrong extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Center(
          child: Text(
            "Something went wrong"
          ),
        ),
      ),
    );
  }
}

class ApiNoDataFound extends StatelessWidget{
  final title;
  ApiNoDataFound({this.title = "No data found!"});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}