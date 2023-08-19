import 'package:flutter/material.dart';
import 'package:lost_get/presentation_layer/screens/authentication/Login/login_screen.dart';
import 'package:lost_get/presentation_layer/screens/authentication/SignUp/sign_up_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case SignUp.routeName:
        return MaterialPageRoute(builder: (context) => const SignUp());
    }
    return null;
  }
}
