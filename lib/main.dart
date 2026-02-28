import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/core/initialization/auth_initializer.dart';

import 'core/router/app_router.dart';
import 'core/storage/shared_pref.dart';
import 'core/theme/app_colors.dart';

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

    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,

      /// ===============================
      /// GLOBAL POS THEME
      /// ===============================
      theme: ThemeData(
        useMaterial3: true,

        /// BACKGROUND
        scaffoldBackgroundColor: AppColors.background,

        /// PRIMARY COLOR
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),

        /// APPBAR
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),

        /// CARD (PRODUCT CARD DLL)
        cardTheme: CardTheme(
          color: AppColors.surface,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        /// BUTTON GLOBAL
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        /// TEXT STYLE
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}