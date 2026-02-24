import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/provider/auth_provider.dart';

class AuthInterceptor extends Interceptor {

  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {

    /// ⭐ TOKEN EXPIRED
    if (err.response?.statusCode == 401) {

      ref
          .read(authProvider.notifier)
          .sessionExpired();
    }

    handler.next(err);
  }
}
