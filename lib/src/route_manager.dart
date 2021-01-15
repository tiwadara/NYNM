import 'package:flutter/material.dart';
import 'package:resolution/src/commons/constants/routes_constant.dart';
import 'package:resolution/src/tasks/screens/tasks.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var argument = settings.arguments;
    switch (settings.name) {
      case Routes.tasks:
        return MaterialPageRoute(builder: (_) => Tasks(argument));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
