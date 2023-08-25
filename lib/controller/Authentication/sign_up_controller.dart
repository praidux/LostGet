import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_get/business_logic_layer/Authentication/Signup/bloc/sign_up_bloc.dart';
import 'package:lost_get/models/user_profile.dart';
import 'package:lost_get/presentation_layer/widgets/toast.dart';

import '../../data_store_layer/repository/users_repository.dart';

class SignUpController {
  final BuildContext context;
  final SignUpBloc signUpBloc;

  SignUpController(this.context, this.signUpBloc);

  Future<void> handleSignUp() async {
    final firstName = signUpBloc.state.firstName;
    final lastName = signUpBloc.state.lastName;
    final emailAddress = signUpBloc.state.emailAddress;
    final password = signUpBloc.state.password;

    if (firstName.isEmpty) {
      createToast(description: 'Enter First Name to continue');
      return;
    } else if (lastName.isEmpty) {
      createToast(description: 'Enter Last Name to continue');
      return;
    } else if (emailAddress.isEmpty) {
      createToast(description: "Enter Email Address to continue");
      return;
    } else if (password.isEmpty) {
      createToast(description: "Enter Password to continue");
      return;
    }

    try {
      final credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credentials.user != null) {
        await credentials.user!.sendEmailVerification();

        UserRepository userRepository = UserRepository();

        UserProfile userProfile = UserProfile(
            firstName: firstName,
            lastName: lastName,
            email: emailAddress,
            isAdmin: false,
            biography: "",
            imgUrl: "",
            phoneNumber: "",
            dateOfBirth: "",
            preferenceList: <String, dynamic>{},
            gender: "");
        await userRepository.createUserProfile(
            credentials.user!.uid, userProfile);

        signUpBloc.add(NavigateToEmailVerificationEvent(credentials));
      } else {
        // User creation failed
        createToast(description: "Some error occurred");
      }
      // if (credentials != null) {}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        createToast(description: "Password is too weak");
      } else if (e.code == 'email-already-in-use') {
        createToast(description: 'Email address already in use');
      } else if (e.code == 'invalid-email') {
        createToast(description: 'Email Address is invalid');
      }
    }
  }
}
