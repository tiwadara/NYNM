import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:resolution/src/commons/constants/app_colors.dart';
import 'package:resolution/src/commons/services/navigation_service.dart';
import 'package:resolution/src/provider_setup.dart';
import 'package:resolution/src/resolutions/screens/resolutions.dart';
import 'package:resolution/src/route_manager.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MultiBlocProvider(
        providers: blocProviders,
        child: MaterialApp(
          title: 'Cronpay',
          theme: ThemeData(
              fontFamily: 'Avenir',
              primaryColor: AppColors.accentDark,
              accentColor: AppColors.primary,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: AppColors.windowColor),
          // darkTheme: ThemeData.dark(),
          home: Resolutions(),
          navigatorKey:
              KiwiContainer().resolve<NavigationService>().navigationKey,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
