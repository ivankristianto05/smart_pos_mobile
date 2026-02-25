class TokenStorage {
  static String? accessToken;
  static String? refreshToken;

  static void saveToken(String token) {
    accessToken = token;
  }

  static void clear() {
    accessToken = null;
    refreshToken = null;
  }
}
