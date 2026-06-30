import 'package:flutter/material.dart';

import '../features/splash/screens/splash_screen.dart';

class AppRouter {

  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {

    return MaterialPageRoute(

      builder: (_) => const SplashScreen(),

    );

  }

}