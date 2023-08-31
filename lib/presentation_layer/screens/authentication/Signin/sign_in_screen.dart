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
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int loginButtonClickCount = 0;
  OverlayEntry? overlayEntry;

  void _handleLogin() {
    try {
      if (formKey.currentState!.validate()) {
        print("validated");
        // Form is valid, proceed with submission
        loginButtonClickCount++;
        SignInController().handleSignIn(context, 'email', signinBloc);
      }
    } catch (e) {}
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
          showCustomLoadingDialog(context);
        }
        if (state is LoginButtonSuccessState) {
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
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText(context, "Login"),
                      SizedBox(
                        height: 18.h,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: TextFormField(
                                controller: _emailAddressController,
                                onChanged: (value) {
                                  // textOnChanged(value);
                                },
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                          .hasMatch(value)) {
                                    print("here");
                                    return 'Email is not correct';
                                  } else {
                                    return null;
                                  }
                                },
                                style: Theme.of(context).textTheme.bodySmall,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      'assets/icons/mail.svg',
                                      height: 10.h,
                                      width: 10.w,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  hintText: 'Your Email',
                                  hintStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 9.h,
                      ),
                      BlocBuilder<SignInBloc, SignInState>(
                        bloc: signinBloc,
                        builder: (context, state) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password field is empty';
                                      }
                                    },
                                    controller: _passwordController,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (password) {},
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                          'assets/icons/lock.svg',
                                          height: 10.h,
                                          width: 10.w,
                                        ),
                                      ),

                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      hintText: 'Your Password',

                                      hintStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            signinBloc.add(
                                                EyeToggleViewClickedEvent());
                                          },
                                          icon: state.isHidden
                                              ? SvgPicture.asset(
                                                  'assets/icons/eye-off.svg',
                                                  height: 10.h,
                                                  width: 10.w,
                                                )
                                              : SvgPicture.asset(
                                                  'assets/icons/eye-on.svg',
                                                  height: 10.h,
                                                  width: 10.w,
                                                )),

                                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                    obscureText: state.isHidden,
                                  ),
                                )
                              ]);
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
                            InkWell(
                                child: SvgPicture.asset(
                                    'assets/icons/facebook_logo.svg')),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                                onTap: () => SignInController().handleSignIn(
                                    context, 'google', signinBloc),
                                child: SvgPicture.asset(
                                    'assets/icons/google_logo.svg')),
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
      ),
    );
  }
}
