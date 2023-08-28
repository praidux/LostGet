import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_get/common/constants/constant.dart';
import 'package:lost_get/common/global.dart';
import 'package:lost_get/presentation_layer/widgets/toast.dart';

import '../../business_logic_layer/Authentication/Signin/bloc/sign_in_bloc.dart';

class SignInController {
  Future<void> handleSignIn(context, String type, SignInBloc signInBloc) async {
    try {
      if (type == 'email') {
        final state = signInBloc.state;

        String emailAddress = state.email;
        String password = state.password;

        if (emailAddress.isEmpty) {
          createToast(description: 'Enter your email address to continue.');
        } else if (password.isEmpty) {
          createToast(description: 'Enter your password to continue.');
        }

        try {
          final credentials = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password)
              .then((userCredential) async {
            final user = userCredential.user;
            if (user != null && user.emailVerified) {
              String? idToken = await userCredential.user!.getIdToken();
              Global.storageService.setString(
                  AppConstants.STORAGE_USER_TOKEN_KEY, idToken.toString());
              signInBloc.add(LoginButtonClickedEvent());
            }
          });

          final user = credentials.user;
          if (user == null) {}
          if (!user!.emailVerified) {
            print("User not verfied");
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            print("No user found for that email");
          } else if (e.code == "wrong-password") {
            print("Wrong password provided for that user");
          } else if (e.code == 'invalid-email') {
            print("You email format is wrong");
          }
          //
        }
      }
    } catch (e) {
      // pass
    }
  }

  static Future<UserCredential?> autoSignIn() async {
    String? idToken = Global.storageService.getTokenId();

    if (idToken != null) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCustomToken(idToken);
        return userCredential;
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  Future<bool> signOut() async {
    if (Global.storageService.removeTokenId()) {
      await FirebaseAuth.instance.signOut();
      return true;
    }

    return false;
  }
}
