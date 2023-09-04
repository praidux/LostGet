import 'package:flutter/material.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/email_verification_screen.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/Signin/sign_in_screen.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/sign_up_screen.dart';
import 'package:lost_get/presentation_layer/screens/Dashboard/dashboard_screen.dart';
import 'package:lost_get/presentation_layer/screens/Onboarding/onboard_screen.dart';
import 'package:lost_get/presentation_layer/screens/Profile%20Settings/Settings/ManageAccount/ChangePhoneNumber/change_phone_number.dart';
import 'package:lost_get/presentation_layer/screens/Profile%20Settings/Settings/ManageAccount/ChangePhoneNumber/ChangePhoneNumberVerification/change_phone_number_verification.dart';
import 'package:lost_get/presentation_layer/screens/Profile%20Settings/Settings/ManageAccount/manage_account.dart';
import '../../presentation_layer/screens/Profile Settings/Settings/ManageAccount/ChangePhoneNumber/ChangePhoneNumberVerified/change_phone_number_verified.dart';
import '../../presentation_layer/screens/Profile Settings/Settings/UserPreference/user_preference_screen.dart';
import '../../presentation_layer/screens/Profile Settings/EditProfile/edit_profile.dart';
import '../../presentation_layer/screens/Profile Settings/Settings/settings_screen.dart';
import '../../presentation_layer/screens/SplashScreen/splash_screen.dart';

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
        return MaterialPageRoute(
            builder: (context) => const EmailVerification());

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

      case ManageAccount.routeName:
        return MaterialPageRoute(builder: (context) => const ManageAccount());

      case ChangePhoneNumber.routeName:
        return MaterialPageRoute(
            builder: (context) => const ChangePhoneNumber());

      case ChangePhoneNumberVerificationScreen.routeName:
        String phoneNumber = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => ChangePhoneNumberVerificationScreen(
                  phoneNumber: phoneNumber,
                ));

      case ChangePhoneNumberVerifiedScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const ChangePhoneNumberVerifiedScreen());
    }
    return null;
  }
}
