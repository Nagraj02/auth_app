import 'package:auth_app/ui/auth/register_page.dart';
import 'package:auth_app/ui/root.dart';
import 'package:auth_app/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<MaterialPageRoute> onNavigate(RouteSettings settings) {
    late final Widget selectedPage;

    switch (settings.name) {
      case SplashPage.route:
        selectedPage = const SplashPage();
        break;
      case RegisterPage.route:
        selectedPage =  RegisterPage();
        break;
      default:
        selectedPage = const Root();
        break;
    }

    return MaterialPageRoute(builder: (context) => selectedPage);
  }
}
