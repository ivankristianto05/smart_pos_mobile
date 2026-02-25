import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';

Future<void> initializeAuth(WidgetRef ref) async {
  await ref.read(authProvider.notifier).checkAuth();
}