import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalValues extends GetxController {
  var isDarkMode = false.obs;
  var version = '1.0.0.0';



  @override
  void onInit() {
    super.onInit();
  }

  Future<void> toggleBrightness(bool value) async {
    isDarkMode.value = value;
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
  }
}
