class AuthService {
  Future<String> login({
    required String email,
    required String password,
  }) async {

    await Future.delayed(const Duration(seconds: 2));

    if (email == "admin@test.com" &&
        password == "123456") {
      return "dummy_access_token";
    }

    throw Exception("Email atau password salah");
  }
}
