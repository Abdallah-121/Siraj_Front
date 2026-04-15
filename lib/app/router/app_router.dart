import 'package:flutter/material.dart';
import 'package:seraj/features/home/presentation/pages/home_page.dart';

import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import 'route_names.dart';

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.welcome:
        return _materialRoute(settings: settings, child: const WelcomePage());
      case RouteNames.login:
        return _materialRoute(settings: settings, child: const LoginPage());
      case RouteNames.register:
        return _materialRoute(settings: settings, child: const RegisterPage());
      case RouteNames.forgotPassword:
        return _materialRoute(
          settings: settings,
          child: const ForgotPasswordPage(),
        );
      case RouteNames.home:
        return _materialRoute(settings: settings, child: const HomePage());
      default:
        return _materialRoute(settings: settings, child: const WelcomePage());
    }
  }

  static MaterialPageRoute<dynamic> _materialRoute({
    required RouteSettings settings,
    required Widget child,
  }) {
    return MaterialPageRoute(settings: settings, builder: (_) => child);
  }
}
