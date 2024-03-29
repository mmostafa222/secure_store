import 'package:shared_preferences/shared_preferences.dart';

class AppLocal {
  static String IMAGE_KEY = 'IMAGE';
  static String DESCRIPTION_KEY = 'DESCRIPTION_KEY';
  static String ISUPLOAD_KEY = 'ISUPLOAD';
  static cacheData(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      prefs.setString(key, value);
    }
  }

  static Future<dynamic> getcachedata(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return
    prefs.get(key);
  }
}
