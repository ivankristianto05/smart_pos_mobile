abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  final String token;

  Authenticated(this.token);
}

class SessionExpired extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
