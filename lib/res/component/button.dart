import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final Function onPress;
  final EdgeInsetsGeometry padding;
  final double width;
  final Color color;

  AppButton(
      {@required this.buttonText,
      @required this.onPress,
      this.padding,
      this.width = double.infinity,
      this.color = Colors.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: 60,
      width: width,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          onPress();
        },
        textColor: Colors.white,
        child: Text(
          buttonText,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
    );
  }
}
