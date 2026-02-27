import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/core/initialization/auth_initializer.dart';

import 'core/router/app_router.dart';
import 'core/storage/shared_pref.dart';
import 'core/network/dio_client.dart';
import 'features/auth/presentation/provider/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.init();

  runApp(
    const ProviderScope(
      child: AuthInitializer(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /// ✅ AMBIL ROUTER DARI PROVIDER
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

