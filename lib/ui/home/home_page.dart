// ignore_for_file: use_build_context_synchronously

import 'package:auth_app/ui/auth/providers/auth_view_model_provider.dart';
import 'package:auth_app/ui/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("H o m e"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authViewModelProvider).logout();
              Navigator.pushReplacementNamed(context, Root.route);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
