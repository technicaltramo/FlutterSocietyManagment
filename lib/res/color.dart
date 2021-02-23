import 'package:flutter/material.dart';

class AppColor{
  static Color appBackground = Colors.white;//_HexColor("e1faeb");
  static Color textFieldBackground = _HexColor("f7faf5");
}

class _HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  _HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
