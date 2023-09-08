import 'package:auth_app/extensions/extensions.dart';
import 'package:auth_app/ui/providers/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Consumer(
          builder: (context, ref, child) {
            final model = ref.watch(loadingProvider);
            return model.loading
                ? Material(
                    color: context.scheme.surfaceVariant.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }
}
