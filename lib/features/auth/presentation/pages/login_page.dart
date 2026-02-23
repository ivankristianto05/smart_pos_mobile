import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/auth_provider.dart';
import '../../domain/auth_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends ConsumerState<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(authProvider.notifier).login(
          _emailController.text,
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {

    final authState = ref.watch(authProvider);

    /// LISTENER STATE CHANGE
    ref.listen<AuthState>(authProvider,
        (previous, next) {

      if (next is Authenticated) {
        context.go('/dashboard');
      }

      if (next is AuthError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    final isLoading =
        authState is Authenticating;

    return Scaffold(
      appBar:
          AppBar(title: const Text("Login")),
      body: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [

              TextFormField(
                controller:
                    _emailController,
                decoration:
                    const InputDecoration(
                  labelText: "Email",
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller:
                    _passwordController,
                obscureText: true,
                decoration:
                    const InputDecoration(
                  labelText: "Password",
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.length < 6) {
                    return "Password minimal 6 karakter";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : _submit,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color:
                              Colors.white)
                      : const Text(
                          "Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
