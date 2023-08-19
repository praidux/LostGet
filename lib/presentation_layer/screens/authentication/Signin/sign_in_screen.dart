import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lost_get/constants/colors.dart';
import 'package:lost_get/presentation_layer/screens/Authentication/SignUp/sign_up_screen.dart';
import 'package:lost_get/presentation_layer/widgets/button.dart';
import 'package:lost_get/presentation_layer/widgets/password_field.dart';

import '../../../../business_logic_layer/Authentication/Signin/bloc/sign_in_bloc.dart';
import '../../../widgets/authentication_widget.dart';
import '../../../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SignInBloc signinBloc = SignInBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<SignInBloc, SignInState>(
        listenWhen: (previous, current) => current is SignInActionState,
        listener: (context, state) {
          if (state is RegisterButtonClickedState) {
            Navigator.pushNamed(context, SignUp.routeName);
          }
        },
        bloc: signinBloc,
        child: Scaffold(
          body: SingleChildScrollView(
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
                      height: 9.h,
                    ),
                    createCheckboxNecessaryItems(context),
                    SizedBox(
                      height: 30.h,
                    ),
                    createButton(context, 'Login'),
                    SizedBox(
                      height: 29.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child:
                                SvgPicture.asset('assets/icons/divider.svg')),
                        const Text(
                          'or continue with',
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.placeHolderColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                            child:
                                SvgPicture.asset('assets/icons/divider.svg')),
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
