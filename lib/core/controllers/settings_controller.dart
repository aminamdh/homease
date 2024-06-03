import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxString language = 'English'.obs;

  void updateUsername(String newUsername) {
    username.value = newUsername;
  }

  void updatePassword(String newPassword) {
    password.value = newPassword;
  }

  void changeLanguage(String newLanguage) {
    language.value = newLanguage;
  }
}
