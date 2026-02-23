import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth_service.dart';
import '../../data/auth_repository.dart';
import '../../domain/auth_state.dart';
import '../notifier/auth_notifier.dart';


/// SERVICE
final authServiceProvider =
    Provider<AuthService>((ref) {
  return AuthService();
});


/// REPOSITORY
final authRepositoryProvider =
    Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(authServiceProvider),
  );
});


/// NOTIFIER
final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    return AuthNotifier(
      ref.read(authRepositoryProvider),
    );
  },
);
