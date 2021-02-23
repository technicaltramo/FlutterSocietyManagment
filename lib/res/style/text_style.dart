import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle text1({int fontSize = 34,Color color = Colors.black}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize.toDouble(),
      color: color,
      fontFamily: 'Ansan'
    );
  }

  static TextStyle text2({Color color = Colors.black54}){
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: color
    );
  }
  static TextStyle cardH2({Color color = Colors.black}){
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: color,
    );
  }

}
