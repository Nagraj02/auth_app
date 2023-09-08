import 'package:auth_app/ui/auth/email_verify_page.dart';
import 'package:auth_app/ui/auth/login_page.dart';
import 'package:auth_app/ui/auth/providers/auth_view_model_provider.dart';
import 'package:auth_app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Root extends ConsumerWidget {
  const Root({super.key});

  static const String route = "/root";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authViewModelProvider);

    return auth.user != null
        ? auth.user!.emailVerified
            ? const HomePage()
            : const EmailVerifyPage()
        : LoginPage();
  }
}
