import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/email_verification_screen.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/Signin/sign_in_screen.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/sign_up_screen.dart';
import 'package:lost_get/presentation_layer/screens/Dashboard/dashboard_screen.dart';
import 'package:lost_get/presentation_layer/screens/Onboarding/onboard_screen.dart';

import '../global.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final loginScreen =
        MaterialPageRoute(builder: (context) => const LoginScreen());
    final dashboardScreen =
        MaterialPageRoute(builder: (context) => const Dashboard());
    switch (routeSettings.name) {
      case '/':
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (deviceFirstOpen) {
          bool isLoggedIn = Global.storageService.getIsLoggedIn();
          if (isLoggedIn) {
            return dashboardScreen;
          }
          return loginScreen;
        } else {
          return MaterialPageRoute(builder: (context) => const OnboardScreen());
        }

      case LoginScreen.routeName:
        return loginScreen;

      case SignUp.routeName:
        return MaterialPageRoute(builder: (context) => const SignUp());

      case EmailVerification.routeName:
        UserCredential userCredential =
            routeSettings.arguments as UserCredential;
        return MaterialPageRoute(
            builder: (context) => EmailVerification(
                  userCredential: userCredential,
                ));

      case Dashboard.routeName:
        return dashboardScreen;
    }
    return null;
  }
}
