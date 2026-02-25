import 'auth_service.dart';

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<Map<String, String>> login(
    String email,
    String password,
  ) async {

    return await _service.login(
      email,
      password,
    );
  }

  Future<String> refreshToken(
    String refreshToken,
  ) async {

    return await _service.refreshToken(
      refreshToken,
    );
  }
}
