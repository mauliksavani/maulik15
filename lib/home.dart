import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HomeController extends GetxController {
  List counterList = [];
  var counter = 1.obs;

  void addValue() {
    counter.value++;
  }

  void removeValue() {
    if (counter.value > 1) {
      counter.value--;
    }

    void delete(){
      removeValue();
    }
  }
}