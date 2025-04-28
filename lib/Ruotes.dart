import 'package:church_admin/view/DashBoard.dart';
import 'package:church_admin/view/LoginScreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String second = '/second';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case second:
        return MaterialPageRoute(builder: (_) => Dashboard());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
