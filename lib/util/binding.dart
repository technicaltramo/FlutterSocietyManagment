
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';


class CB<T extends GetxController> extends Bindings{
  final T controller;
  CB(this.controller);
  @override
  void dependencies() {
   Get.put(controller);
  }
}
