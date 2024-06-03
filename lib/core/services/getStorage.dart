import 'package:get/get.dart';

import '../helpers/getStorage_helper.dart';

class gsService extends GetxService {
  static void setTheme(bool theme) {
    GetStorageHelper.writeboolGS("theme", theme);
  }

  static bool getTheme() {
    return GetStorageHelper.readboolGS("theme") ?? false;
  }

  static void setLocale(String ColdeLang) {
    GetStorageHelper.writeStringGS("locale", ColdeLang);
  }

  static String getLocale() {
    return GetStorageHelper.readStringGS("locale") ?? "";
  }
}
