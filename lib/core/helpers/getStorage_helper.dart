import 'package:get_storage/get_storage.dart';

class GetStorageHelper {
  static final GSinstance = GetStorage();
  
  static String? readStringGS(String key) {
    return GSinstance.read(key);
  }

  static int? readintGS(String key) {
    return GSinstance.read(key);
  }

  static bool? readboolGS(String key) {
    return GSinstance.read(key);
  }

  static void writeStringGS(String key, String value) {
    GSinstance.write(key, value);
  }

  static void writeintGS(String key, int value) {
    GSinstance.write(key, value);
  }

  static void writeboolGS(String key, bool value) {
    GSinstance.write(key, value);
  }

  static void writeToken(String token) {
    GSinstance.write('token', token);
  }

  static String? readToken() {
    return GSinstance.read('token');
  }

  static void deleteToken() {
    GSinstance.remove('token');
  }
}
