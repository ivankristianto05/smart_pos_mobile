import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/core/network/dio_client.dart';
import 'package:smart_pos_mobile/core/storage/shared_pref.dart';

import '../../domain/auth_state.dart';
import '../../data/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository)
      : super(Unauthenticated());

  Future<void> checkAuth() async {
    final token = AppPreferences.getToken();

    if (token != null) {
      state = Authenticated(token);
    } else {
      state = Unauthenticated();
    }
  }

  Future<void> login(
      String email,
      String password) async {

    state = Authenticating();

    try {
      final token =
          await _repository.login(email, password);

      await AppPreferences.setToken(token);

      state = Authenticated(token);

    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> logout() async {
  await AppPreferences.clear();
  state = Unauthenticated();
}


  Future<void> sessionExpired() async {
    await AppPreferences.clear();
    state = SessionExpired();
  }

  
}

