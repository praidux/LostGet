import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lost_get/controller/Authentication/sign_in_controller.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/sign_up_screen.dart';
import 'package:lost_get/presentation_layer/widgets/button.dart';
import 'package:lost_get/presentation_layer/widgets/password_field.dart';
import 'package:lost_get/presentation_layer/widgets/toast.dart';

import '../../../../business_logic_layer/Authentication/Signin/bloc/sign_in_bloc.dart';
import '../../../widgets/authentication_widget.dart';
import '../../../widgets/please_wait.dart';
import '../../../widgets/text_field.dart';
import '../../Dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SignInBloc signinBloc = SignInBloc();
  int loginButtonClickCount = 0;
  OverlayEntry? overlayEntry;

  void _handleLogin() {
    loginButtonClickCount++;
    SignInController().handleSignIn(context, 'email', signinBloc);
  }

  void showCustomLoadingDialog(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned.fill(
          child: Container(
            color: Colors.transparent
                .withOpacity(0.7), // Make the overlay transparent
            child: const Center(
              child: PleaseWaitDialog(description: "Logging in..."),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void hideCustomLoadingDialog(BuildContext context) {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      bloc: signinBloc,
      listener: (context, state) {
        if (state is RegisterButtonClickedState) {
          Navigator.pushNamed(context, SignUp.routeName);
        }

        if (state is LoginButtonLoadingState) {
          print("was in laoding");
          showCustomLoadingDialog(context);
        }
        if (state is LoginButtonSuccessState) {
          print("was in loaded");
          hideCustomLoadingDialog(context);
          Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
        }

        if (state is LoginButtonErrorState) {
          hideCustomLoadingDialog(context);
          createToast(description: state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingText(context, "Login"),
                    SizedBox(
                      height: 18.h,
                    ),
                    BlocBuilder<SignInBloc, SignInState>(
                      bloc: signinBloc,
                      builder: (context, state) {
                        return InputTextField(
                          textHint: 'Your Email',
                          title: 'E-mail',
                          imageUrl: 'assets/icons/mail.svg',
                          textOnChanged: (email) =>
                              signinBloc.add(EmailOnChangedEvent(email: email)),
                        );
                      },
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    BlocBuilder<SignInBloc, SignInState>(
                      bloc: signinBloc,
                      builder: (context, state) {
                        return PasswordField(
                          textHint: 'Your Password',
                          title: 'Password',
                          imageUrl: 'assets/icons/lock.svg',
                          isHidden: state.isHidden,
                          toggleEye: () {
                            signinBloc.add(EyeToggleViewClickedEvent());
                          },
                          passwordOnChange: (password) => signinBloc
                              .add(PasswordOnChangedEvent(password: password)),
                        );
                      },
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    createCheckboxNecessaryItems(context),
                    SizedBox(
                      height: 30.h,
                    ),
                    CreateButton(
                      title: 'Login',
                      handleButton: _handleLogin,
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        )),
                        Text(
                          'or continue with',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/facebook_logo.svg'),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset('assets/icons/google_logo.svg'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    createRichTextForLoginSignUp(
                        context,
                        'Don\'t have an account? ',
                        'Register Now',
                        () => signinBloc.add(RegisterButtonClickedEvent())),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
