import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/email_verification_screen.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/Signin/sign_in_screen.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/sign_up_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case SignUp.routeName:
        return MaterialPageRoute(builder: (context) => const SignUp());

      case EmailVerification.routeName:
        UserCredential userCredential =
            routeSettings.arguments as UserCredential;
        return MaterialPageRoute(
            builder: (context) => EmailVerification(
                  userCredential: userCredential,
                ));
    }
    return null;
  }
}
