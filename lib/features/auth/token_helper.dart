import 'package:jwt_decoder/jwt_decoder.dart';
import '../../core/storage/shared_pref.dart';

class TokenHelper {

  /// =============================
  /// TOKEN FROM STORAGE
  /// =============================

  static Future<String?> getAccessToken() async {
    return AppPreferences.getToken();
  }

  static Future<String?> getRefreshToken() async {
    return AppPreferences.getRefreshToken();
  }

  /// =============================
  /// JWT CHECK
  /// =============================

  static bool isExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  static Duration timeRemaining(String token) {
    return JwtDecoder.getRemainingTime(token);
  }
}