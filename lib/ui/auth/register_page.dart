// ignore_for_file: use_build_context_synchronously

import 'package:auth_app/extensions/extensions.dart';
import 'package:auth_app/ui/auth/providers/auth_view_model_provider.dart';
import 'package:auth_app/ui/components/app_snack_bar.dart';
import 'package:auth_app/ui/components/loading_layer.dart';
import 'package:auth_app/ui/root.dart';
import 'package:auth_app/utils/labels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});
  final _formKey = GlobalKey<FormState>();

  static const String route = "/register";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = authViewModelProvider;
    final model = ref.read(provider);

    return LoadingLayer(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Icon(
                  Icons.favorite,
                  size: 80,
                  color: context.scheme.primary,
                ),
                const SizedBox(height: 8.0),
                Text(
                  Labels.appName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: context.style.titleLarge,
                ),
                 const Spacer(),
                Text(
                  Labels.signUp,
                  style: context.style.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  initialValue: model.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    labelText: Labels.email,
                  ),
                  onChanged: (value) => model.email = value,
                  validator: (value) => model.emailValidate(value!),
                ),
                const SizedBox(height: 16.0),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(
                        provider.select((value) => value.obscurePassword));
                    return TextFormField(
                      initialValue: model.password,
                      obscureText: model.obscurePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: Labels.password,
                        suffixIcon: IconButton(
                          onPressed: () {
                            model.obscurePassword = !model.obscurePassword;
                          },
                          icon: Icon(
                            model.obscurePassword
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                        ),
                      ),
                      onChanged: (value) => model.password = value,
                      validator: (value) => model.passwordValidate(value!),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider
                        .select((value) => value.obscureConfirmPassword));
                    return TextFormField(
                      initialValue: model.password,
                      obscureText: model.obscureConfirmPassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: Labels.confirmPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            model.obscureConfirmPassword =
                                !model.obscureConfirmPassword;
                          },
                          icon: Icon(
                            model.obscureConfirmPassword
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                        ),
                      ),
                      onChanged: (value) => model.confirmPassword = value,
                      validator: (value) => value!=model.password? "Password didn't match!":null,
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider);
                    return MaterialButton(
                      color: context.scheme.primaryContainer,
                      padding: const EdgeInsets.all(16.0),
                      onPressed: model.email.isNotEmpty &&
                              model.password.isNotEmpty &&
                              model.confirmPassword.isNotEmpty
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await model.register();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Root.route,
                                    (route) => false,
                                  );
                                } catch (e) {
                                  AppSnackBar(context).error(e);
                                }
                              }
                            }
                          : null,
                      child: Text(
                        Labels.signUp.toUpperCase(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: Labels.alreadyHaveAnAccount,
                    style: context.style.bodyLarge,
                    children: [
                      TextSpan(
                        text: Labels.signIn,
                        style: context.style.labelLarge!.copyWith(
                          fontSize: context.style.bodyLarge!.fontSize,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, RegisterPage.route);
                          },
                      ),
                    ],
                  ),
                ),
                 const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
