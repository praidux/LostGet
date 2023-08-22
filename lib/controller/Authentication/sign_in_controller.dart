import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_get/common/constants/constant.dart';
import 'package:lost_get/common/global.dart';
import 'package:lost_get/presentation_layer/widgets/toast.dart';

import '../../business_logic_layer/Authentication/Signin/bloc/sign_in_bloc.dart';

class SignInController {
  final BuildContext context;
  final SignInBloc signInBloc;

  SignInController(this.context, this.signInBloc);

  Future<void> handleSignIn(String type) async {
    try {
      if (type == 'email') {
        final state = signInBloc.state;
        bool isLoading = true;
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
              .then((userCredential) {
            final user = userCredential.user;
            if (user != null && user.emailVerified) {
              Global.storageService
                  .setString(AppConstants.STORAGE_USER_TOKEN_KEY, "1234567");
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
}
