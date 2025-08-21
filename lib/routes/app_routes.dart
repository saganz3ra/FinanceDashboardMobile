import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/login_page.dart';
import '../screens/dashboard_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    dashboard: (context) => DashboardPage(),
  };
}
