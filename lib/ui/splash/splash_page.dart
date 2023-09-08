import 'package:auth_app/extensions/extensions.dart';
import 'package:auth_app/ui/root.dart';
import 'package:auth_app/utils/labels.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String route = "/";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).whenComplete(() =>
        Navigator.pushNamedAndRemoveUntil(
            context, Root.route, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_sharp,
              size: 80.0,
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              Labels.appName,
              style: context.style.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.scheme.onPrimaryContainer),
            ),
          ],
        ),
      ),
    );
  }
}
