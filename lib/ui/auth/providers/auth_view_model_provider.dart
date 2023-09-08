import 'package:auth_app/ui/providers/loading_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = ChangeNotifierProvider(
  (ref) => AuthViewModel(ref),
);

class AuthViewModel extends ChangeNotifier {
  final Ref _ref;
  AuthViewModel(this._ref);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  String _email = '';
  String get email => _email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  set obscurePassword(bool obscureText) {
    _obscurePassword = obscureText;
    notifyListeners();
  }

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  set obscureConfirmPassword(bool obscureConfirmPassword) {
    _obscureConfirmPassword = obscureConfirmPassword;
    notifyListeners();
  }

  String? emailValidate(String value) {
    const String format =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return !RegExp(format).hasMatch(value) ? "Enter valid email" : null;
  }

  String? passwordValidate(String value) {
    const String format = r"(?=^.{8,}$)((?=.*\d)|)(?![.\n]).*$";
    if (password.length <= 7) {
      return ("Password must be more than 7 characters");
    }
    return !RegExp(format).hasMatch(value) ? "Enter valid password" : null;
  }

  Loading get _loading => _ref.read(loadingProvider);

  Future<void> login() async {
    _loading.start();
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _loading.end();
    } on FirebaseAuthException catch (e) {
      _loading.stop();

      if (e.code == "wrong-password") {
        return Future.error("Wrong password! Please enter correct password.");
      } else if (e.code == "user-not-found") {
        return Future.error("User not found!");
      } else {
        return Future.error(e.message ?? "");
      }
    } catch (e) {
      _loading.stop();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> register() async {
    _loading.start();
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _loading.end();
    } on FirebaseAuthException catch (e) {
      _loading.stop();

      if (e.code == "email-already-in-use") {
        return Future.error(
          "Email already in use",
        );
      }
      if (e.code == "weak-password") {
        return Future.error(
          "Weak password! Please enter strong password.",
        );
      } else {
        return Future.error(e.message ?? "");
      }
    } catch (e) {
      _loading.stop();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> reload() async {
    await _auth.currentUser!.reload();
  }

  void sendEmail() {
    _auth.currentUser!.sendEmailVerification();
  }
}
