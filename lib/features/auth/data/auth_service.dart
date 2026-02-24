import 'package:dio/dio.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<String> login(
    String email,
    String password,
  ) async {

    /// ✅ SIMULASI API DELAY
    await Future.delayed(
      const Duration(seconds: 1),
    );

    /// ✅ FAKE VALIDATION
    if (email == "admin@mail.com" &&
        password == "123456") {

      return "mock_token_123";
    }

    throw Exception("Email / Password salah");
  }
}
