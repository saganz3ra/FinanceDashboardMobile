import 'package:flutter/material.dart';
import '../shared/widgets/pages/home_page.dart';
import '../shared/widgets/pages/login_page.dart';
import '../shared/widgets/pages/dashboard_page.dart';
import '../shared/widgets/pages/register_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String register = '/register';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    dashboard: (context) => const DashboardPage(),
    register: (context) => const RegisterPage(),
  };
}
