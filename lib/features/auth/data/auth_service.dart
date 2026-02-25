import 'package:dio/dio.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<Map<String, String>> login(
  String email,
  String password,
) async {

  await Future.delayed(
    const Duration(seconds: 1),
  );

  if (email == "admin@mail.com" &&
      password == "123456") {

    return {
      "access_token": "mock_access_token",
      "refresh_token": "mock_refresh_token",
    };
  }

  throw Exception("Login gagal");
}


  /// ⭐ MOCK REFRESH TOKEN
  Future<String> refreshToken(
      String refreshToken) async {

    await Future.delayed(
      const Duration(seconds: 1),
    );

    /// simulasi refresh berhasil
    if (refreshToken ==
        "mock_refresh_token") {

      return "new_access_token";
    }

    throw Exception("Refresh gagal");
  }
}
