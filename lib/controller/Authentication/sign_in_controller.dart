import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lost_get/common/constants/constant.dart';
import 'package:lost_get/common/global.dart';

import 'package:lost_get/presentation_layer/widgets/toast.dart';

import '../../business_logic_layer/Authentication/Signin/bloc/sign_in_bloc.dart';
import '../../data_store_layer/repository/users_repository.dart';
import '../../models/user_profile.dart';

class SignInController {
  final UserRepository _userRepository = UserRepository();
  Future<void> handleSignIn(context, String type, SignInBloc signInBloc) async {
    try {
      if (type == 'email') {
        final state = signInBloc.state;

        String emailAddress = state.email;
        String password = state.password;

        if (emailAddress.isEmpty) {
          createToast(description: 'Enter your email address to continue.');
          return;
        } else if (password.isEmpty) {
          createToast(description: 'Enter your password to continue.');
          return;
        }

        try {
          signInBloc.add(LoginButtonLoadingEvent());
          final credentials = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password)
              .then((userCredential) async {
            final user = userCredential.user;
            if (user != null && user.emailVerified) {
              String? idToken = await userCredential.user!.getIdToken();
              print("Token generated");
              Global.storageService
                  .setString(
                      AppConstants.STORAGE_USER_TOKEN_KEY, idToken.toString())
                  .whenComplete(
                      () => signInBloc.add(LoginButtonSuccessEvent()));
            }
          });

          final user = credentials.user;

          if (!user!.emailVerified) {
            signInBloc.add(LoginButtonErrorEvent("User not verfied"));
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            signInBloc
                .add(LoginButtonErrorEvent("No user found for that email"));
          } else if (e.code == "wrong-password") {
            signInBloc.add(LoginButtonErrorEvent("Email or password is wrong"));
          } else if (e.code == 'invalid-email') {
            signInBloc.add(LoginButtonErrorEvent("Email or password is wrong"));
          }
          //
        }
      } else if (type == 'google') {
        try {
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          signInBloc.add(LoginButtonLoadingEvent());

          final GoogleSignInAuthentication? googleAuth =
              await googleUser?.authentication;

          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          // ignore: unnecessary_null_comparison
          if (userCredential != null) {
            bool isNewUser =
                await _userRepository.isNewUser(userCredential.user!.uid);

            if (isNewUser) {
              User? user = userCredential.user;
              String? fullName = user!.displayName;
              String? emailAddress = user.email;

              UserProfile userProfile = UserProfile(
                  fullName: fullName,
                  email: emailAddress,
                  isAdmin: false,
                  biography: "",
                  imgUrl: "",
                  phoneNumber: "",
                  dateOfBirth: "",
                  preferenceList: <String, dynamic>{},
                  gender: "");

              await _userRepository.createUserProfile(
                  userCredential.user!.uid, userProfile);
            }
            String? idToken = await userCredential.user!.getIdToken();
            print("New token: $idToken");
            Global.storageService
                .setString(
                    AppConstants.STORAGE_USER_TOKEN_KEY, idToken.toString())
                .whenComplete(() => signInBloc.add(LoginButtonSuccessEvent()));
          }
        } catch (e) {
          signInBloc.add(LoginButtonErrorEvent("Error Occurred"));
        }
      }
    } catch (e) {
      signInBloc.add(LoginButtonErrorEvent("Error occurred"));
      // pass
    }
  }

  static Future<UserCredential?> autoSignIn() async {
    print("Entered");
    String? idToken = Global.storageService.getTokenId();
    print("Token is $idToken");

    if (idToken != null) {
      print("INSDIE");
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCustomToken(idToken);
        print(userCredential.user!.email);
        return userCredential;
      } catch (e) {
        print("error: $e");
        createToast(description: "Some Error Occurred");
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> signOut() async {
    if (await Global.storageService.removeTokenId()) {
      await FirebaseAuth.instance.signOut();
      return true;
    }

    return false;
  }
}
