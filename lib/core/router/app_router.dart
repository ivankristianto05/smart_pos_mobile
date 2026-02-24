import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pos_mobile/features/dashboard/dashboard_page.dart';

import '../../features/auth/presentation/provider/auth_provider.dart';
import '../../features/auth/domain/auth_state.dart';

import '../../features/auth/presentation/pages/login_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {

  /// ⭐ LISTEN AUTH STATE
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',

    redirect: (context, state) {

      final isLogin = state.matchedLocation == '/login';

      /// ✅ BELUM LOGIN
      if (authState is Unauthenticated) {
        return isLogin ? null : '/login';
      }

      /// ✅ SUDAH LOGIN
      if (authState is Authenticated) {
        return isLogin ? '/dashboard' : null;
      }

      /// loading / authenticating
      return null;
    },

    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (_, __) => const DashboardPage(),
      ),
    ],
  );
});
