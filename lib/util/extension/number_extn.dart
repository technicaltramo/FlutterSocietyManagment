import 'dart:math';

extension IntExtension on num {
  bool isBetween(num from, num to) {
    return from < this && this < to;
  }
}

extension DoubleExtension on double {
  double myDoubleFunction({int places = 2}) {
    double mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}
