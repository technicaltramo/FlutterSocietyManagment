import 'package:flutter/material.dart';

class AppBoxStyle{
  static BoxDecoration loginFormBackgroundStyle(){
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)));
  }
}