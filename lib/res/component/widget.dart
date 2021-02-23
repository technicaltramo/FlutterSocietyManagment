import 'package:flutter/material.dart';

class AppWidget {

  static width({int value = 8}) {
    return SizedBox(
      width: value.toDouble(),
    );
  }

  static height({int value = 8}) {
    return SizedBox(
      height: value.toDouble(),
    );
  }
}

class Nothing extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }

}

class BuildHorizontalLine extends StatelessWidget{
  final color;
  final int height;
  BuildHorizontalLine({this.color = Colors.grey,this.height = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.toDouble(),
      width: double.infinity,
      color: color[300],
    );
  }

}

class BuildVerticalLine extends StatelessWidget{
  final color;
  final int width;
  final int height;
  BuildVerticalLine(this.height,{this.color = Colors.grey,this.width = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.toDouble(),
      width: width.toDouble(),
      color: color,
    );
  }

}
