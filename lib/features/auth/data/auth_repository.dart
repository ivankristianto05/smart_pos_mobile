import 'auth_service.dart';

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<String> login(
    String email,
    String password,
  ) async {
    try {
      final token =
          await _service.login(email, password);

      return token;
    } catch (e) {
      throw Exception("Login gagal");
    }
  }
}
