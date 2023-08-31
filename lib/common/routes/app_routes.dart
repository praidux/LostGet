import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_get/controller/Authentication/sign_in_controller.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/email_verification_screen.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/Signin/sign_in_screen.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/sign_up_screen.dart';
import 'package:lost_get/presentation_layer/screens/Dashboard/dashboard_screen.dart';
import 'package:lost_get/presentation_layer/screens/Onboarding/onboard_screen.dart';

import '../../presentation_layer/screens/Profile Settings/Settings/UserPreference/user_preference_screen.dart';
import '../../presentation_layer/screens/Profile Settings/EditProfile/edit_profile.dart';
import '../../presentation_layer/screens/Profile Settings/Settings/settings_screen.dart';
import '../../presentation_layer/screens/SplashScreen/splash_screen.dart';
import '../global.dart';
import '../../../common/constants/profile_settings_constants.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final loginScreen =
        MaterialPageRoute(builder: (context) => const LoginScreen());

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashScreen());

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
        return MaterialPageRoute(builder: (context) => const Dashboard());

      case EditProfile.routeName:
        return MaterialPageRoute(builder: (context) => const EditProfile());

      case EditProfileSettings.routeName:
        return MaterialPageRoute(
            builder: (context) => const EditProfileSettings());

      case UserPreferenceScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const UserPreferenceScreen());

      case OnboardScreen.routeName:
        return MaterialPageRoute(builder: (context) => const OnboardScreen());
    }
    return null;
  }
}
