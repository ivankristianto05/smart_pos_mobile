import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/shared_pref.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';
import 'dio_client.dart';

class AuthInterceptor extends Interceptor {

  final Ref ref;

  AuthInterceptor(this.ref);

  bool _isRefreshing = false;

  final List<RequestOptions> _queue = [];

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler) {

    final token = AppPreferences.getToken();

    if (token != null) {
      options.headers['Authorization'] =
          'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler) async {

    final request = err.requestOptions;

    /// ✅ BUKAN 401 → lanjut
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    /// =============================
    /// ✅ ANTI INFINITE LOOP
    /// =============================
    if (request.extra['isRetry'] == true) {

      await ref
          .read(authProvider.notifier)
          .sessionExpired();

      handler.next(err);
      return;
    }

    /// =============================
    /// REFRESH SEDANG BERJALAN
    /// =============================
    if (_isRefreshing) {
      _queue.add(request);
      return;
    }

    _isRefreshing = true;

    final newToken =
        await ref
            .read(authProvider.notifier)
            .refreshToken();

    /// REFRESH GAGAL
    if (newToken == null) {
      _isRefreshing = false;
      handler.next(err);
      return;
    }

    final dio = ref.read(dioProvider);

    /// =============================
    /// RETRY ORIGINAL REQUEST
    /// =============================
    request.headers['Authorization'] =
        'Bearer $newToken';

    request.extra['isRetry'] = true;

    final response =
        await dio.fetch(request);

    /// =============================
    /// PROCESS QUEUE
    /// =============================
    for (final queuedRequest in _queue) {

      queuedRequest.headers['Authorization'] =
          'Bearer $newToken';

      queuedRequest.extra['isRetry'] = true;

      await dio.fetch(queuedRequest);
    }

    _queue.clear();
    _isRefreshing = false;

    handler.resolve(response);
  }
}
