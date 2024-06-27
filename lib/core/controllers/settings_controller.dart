import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxString language = 'en_US'.obs; // Default language set to English

  void updateUsername(String newUsername) {
    username.value = newUsername;
  }

  void updatePassword(String newPassword) {
    password.value = newPassword;
  }

  void changeLanguage(String newLanguage) {
    language.value = newLanguage;
    var locale = Locale(newLanguage.split('_')[0], newLanguage.split('_')[1]);
    Get.updateLocale(locale);
  }
}
