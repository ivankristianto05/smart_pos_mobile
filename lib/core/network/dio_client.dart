import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/shared_pref.dart';
import 'auth_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {

  final token = AppPreferences.getToken();

  final dio = Dio(
    BaseOptions(
      baseUrl: 'YOUR_BASE_URL',
      headers: {
        if (token != null)
          'Authorization': 'Bearer $token',
      },
    ),
  );

  /// ⭐ ADD INTERCEPTOR
  dio.interceptors.add(
    AuthInterceptor(ref),
  );

  return dio;
});
