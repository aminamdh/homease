import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  ThemeMode theme = ThemeMode.system;
  Locale? lang = Get.deviceLocale;
  @override
  void onInit() {}
}
