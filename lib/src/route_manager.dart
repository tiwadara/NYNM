import 'package:flutter/material.dart';
import 'package:resolution/src/commons/constants/routes_constant.dart';
import 'package:resolution/src/resolutions/screens/new_resolution.dart';
import 'package:resolution/src/resolutions/screens/resolutions.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.resolutions:
        return MaterialPageRoute(builder: (_) => Resolutions());
      case Routes.newResolution:
        return MaterialPageRoute(builder: (_) => NewResolution());
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
