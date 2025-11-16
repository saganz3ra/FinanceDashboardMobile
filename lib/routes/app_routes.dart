import 'package:flutter/material.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/dashboard_page.dart';
import '../presentation/pages/register_page.dart';

class AppRoutes {
  static const String login = '/';
  static const String dashboard = '/dashboard';
  static const String register = '/register';

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginPage(),
    dashboard: (context) => const DashboardPage(),
    register: (context) => const RegisterPage(),
  };
}
