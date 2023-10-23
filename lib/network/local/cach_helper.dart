import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, required value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    } else if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else {
      return await sharedPreferences!.setDouble(key, value);
    }
  }

  static bool? getBoolean({required String key}) {
    return sharedPreferences!.getBool(key);
  }

  static int? getInteger({required String key}) {
    return sharedPreferences!.getInt(key);
  }
  static String? getString({required String key}) {
    return sharedPreferences!.getString(key);
  }

  static Future<bool> removeData({required String key}) async {
    return sharedPreferences!.remove(key);
  }
}
