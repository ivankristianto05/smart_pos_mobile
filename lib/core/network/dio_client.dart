import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {

  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.test.com",
    ),
  );

  /// ✅ PASS REF (BUKAN DIO)
  dio.interceptors.add(
    AuthInterceptor(ref),
  );

  return dio;
});
