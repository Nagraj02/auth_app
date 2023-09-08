// ignore_for_file: use_build_context_synchronously

import 'package:auth_app/extensions/extensions.dart';
import 'package:auth_app/ui/auth/providers/auth_view_model_provider.dart';
import 'package:auth_app/ui/components/app_snack_bar.dart';
import 'package:auth_app/ui/root.dart';
import 'package:auth_app/utils/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerifyPage extends ConsumerWidget {
  const EmailVerifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(authViewModelProvider);
    model.sendEmail();
    return Scaffold( 
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(
              Labels.verifyYourEmail,
              style: context.style.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              Labels.verificationEmailLink(model.user!.email!),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await model.reload();
                  if (model.user!.emailVerified) {
                    Navigator.pushReplacementNamed(context, Root.route);
                  } else {
                    AppSnackBar(context).error("Email not verified yet!");
                  }
                },
                child: const Text(
                  Labels.done,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
