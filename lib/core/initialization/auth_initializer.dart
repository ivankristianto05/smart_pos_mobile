import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pos_mobile/features/auth/presentation/provider/auth_provider.dart';

class AuthInitializer extends ConsumerStatefulWidget {
  final Widget child;

  const AuthInitializer({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<AuthInitializer> createState()
      => _AuthInitializerState();
}

class _AuthInitializerState
    extends ConsumerState<AuthInitializer> {

  @override
  void initState() {
    super.initState();

    /// ✅ DIJALANKAN SEKALI SAJA
    Future.microtask(() {
      ref.read(authProvider.notifier)
          .checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}