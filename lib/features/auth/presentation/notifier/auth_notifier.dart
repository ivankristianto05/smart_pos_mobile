import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/auth_state.dart';
import '../../data/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository)
      : super(Unauthenticated());

  Future<void> login(
      String email,
      String password) async {

    state = Authenticating();

    try {
      final token =
          await _repository.login(email, password);

      state = Authenticated(token);

    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  void logout() {
    state = Unauthenticated();
  }

  void sessionExpired() {
    state = SessionExpired();
  }
}
