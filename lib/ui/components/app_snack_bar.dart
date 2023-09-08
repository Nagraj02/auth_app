import 'package:auth_app/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  final BuildContext context;

  AppSnackBar(this.context);

  void error(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$e",
          style: context.style.bodyLarge!.copyWith(
            color: context.scheme.onErrorContainer,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.scheme.errorContainer,
      ),
    );
  }
}
