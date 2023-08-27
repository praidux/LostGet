import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lost_get/business_logic_layer/Authentication/Signup/bloc/sign_up_bloc.dart';
import 'package:lost_get/controller/Authentication/sign_up_controller.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/email_verification_screen.dart';
import 'package:lost_get/presentation_layer/widgets/button.dart';
import '../../../widgets/authentication_widget.dart';
import '../../../widgets/password_field.dart';
import '../../../widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const routeName = '/sign_up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpBloc signUpBloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<SignUpBloc, SignUpState>(
        bloc: signUpBloc,
        listener: (context, state) {
          if (state is LoginButtonClickedState) {
            Navigator.of(context).pop();
          }
          if (state is NavigateToEmailVerificationState) {
            print("User is here ${state.userCredential.user!.email}");
            UserCredential userCredential = state.userCredential;
            Navigator.popAndPushNamed(context, EmailVerification.routeName,
                arguments: userCredential);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              iconSize: 24,
              icon: SvgPicture.asset(
                'assets/icons/onBack.svg',
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingText(context, 'Sign Up'),
                    SizedBox(
                      height: 18.h,
                    ),
                    InputTextField(
                      textHint: 'Your Full Name',
                      title: 'Full Name',
                      imageUrl: 'assets/icons/profile.svg',
                      textOnChanged: (firstName) {
                        signUpBloc.add(FirstNameOnChangedEvent(firstName));
                      },
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    InputTextField(
                      textHint: 'Your Email',
                      title: 'E-mail',
                      imageUrl: 'assets/icons/mail.svg',
                      textOnChanged: (email) {
                        signUpBloc.add(EmailOnChangedEvent(email));
                      },
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      bloc: signUpBloc,
                      builder: (context, state) {
                        return PasswordField(
                            textHint: 'Your Password',
                            title: 'Password',
                            imageUrl: 'assets/icons/lock.svg',
                            isHidden: state.isHidden,
                            toggleEye: () {
                              signUpBloc.add(EyeToggleViewClickedEvent());
                            },
                            passwordOnChange: (password) {
                              signUpBloc.add(PasswordOnChangedEvent(password));
                            });
                      },
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "By signing up you agree to our ",
                          style: Theme.of(context).textTheme.bodySmall,
                          children: [
                            const TextSpan(
                                text: "Terms & Condition",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                            TextSpan(
                                text: " and ",
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: "Privacy Policy.*",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {})
                          ]),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CreateButton(
                        title: 'Register Now',
                        handleButton: () {
                          SignUpController(context, signUpBloc).handleSignUp();
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    createRichTextForLoginSignUp(
                        context, 'Already a member? ', 'Login', () {
                      signUpBloc.add(LoginButtonClickedEvent());
                    }),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
