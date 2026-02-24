import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences _prefs;

  /// INIT WAJIB sebelum runApp
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// TOKEN
  static Future<void> setToken(String token) async {
    await _prefs.setString('token', token);
  }

  static String? getToken() {
    return _prefs.getString('token');
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }
}
