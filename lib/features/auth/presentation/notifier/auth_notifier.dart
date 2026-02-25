import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/core/network/dio_client.dart';
import 'package:smart_pos_mobile/core/storage/shared_pref.dart';
import 'package:smart_pos_mobile/core/storage/token_storage.dart';

import '../../domain/auth_state.dart';
import '../../data/auth_repository.dart';
import 'dart:async';
import '../../token_helper.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  Timer? _refreshTimer;

  AuthNotifier(this._repository)
      : super(Unauthenticated());

  Future<void> checkAuth() async {

  final token =
      await TokenHelper.getAccessToken();

  /// belum login
  if (token == null) {
    state = Unauthenticated();
    return;
  }

  /// cek expired
  final isExpired =
      TokenHelper.isExpired(token);

  if (isExpired) {

    final newToken =
        await refreshToken();

    if (newToken == null) {
      await logout();
      return;
    }

    state = Authenticated(newToken);
    return;
  }

  /// token masih valid
  state = Authenticated(token);
}
  Future<void> login(
  String email,
  String password,
) async {

  state = Authenticating();

  try {

    final tokens =
        await _repository.login(
            email,
            password);
TokenStorage.saveToken(
  tokens['access_token']!,
);
    await AppPreferences.setToken(
        tokens['access_token']!);

    await AppPreferences
        .setRefreshToken(
            tokens['refresh_token']!);

    state = Authenticated(
        tokens['access_token']!);

  } catch (e) {
    state = AuthError(e.toString());
  }
}
Future<String?> refreshToken() async {

  final refreshToken =
      AppPreferences.getRefreshToken();

  if (refreshToken == null) {
    await sessionExpired();
    return null;
  }

  try {

    final newToken =
        await _repository
            .refreshToken(refreshToken);

    await AppPreferences
        .setToken(newToken);

    return newToken;

  } catch (_) {

    await sessionExpired();
    return null;
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

