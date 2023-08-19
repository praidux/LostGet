import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lost_get/constants/colors.dart';
import 'package:lost_get/presentation_layer/screens/authentication/SignUp/sign_up_screen.dart';
import 'package:lost_get/presentation_layer/widgets/authentication/authentication_widget.dart';
import 'package:lost_get/presentation_layer/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              headingText(context, "Login"),
              const SizedBox(
                height: 36,
              ),
              getTextFields(
                context,
                'Your Email',
                'E-mail',
                'assets/icons/mail.svg',
              ),
              const SizedBox(
                height: 18,
              ),
              getPasswordFields(
                context,
                'Your Password',
                'Password',
                'assets/icons/lock.svg',
                _isHidden,
                _togglePasswordView,
              ),
              const SizedBox(
                height: 18,
              ),
              createCheckboxNecessaryItems(context),
              const SizedBox(
                height: 59,
              ),
              createButton(context, 'Login'),
              const SizedBox(
                height: 78,
              ),
              Row(
                children: [
                  Expanded(child: SvgPicture.asset('assets/icons/divider.svg')),
                  const Text(
                    'or continue with',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.placeHolderColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(child: SvgPicture.asset('assets/icons/divider.svg')),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 1,
                      child:
                          SvgPicture.asset('assets/icons/facebook_logo.svg')),
                  Expanded(
                      flex: 1,
                      child: SvgPicture.asset('assets/icons/google_logo.svg')),
                  const Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              const SizedBox(
                height: 156,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.of(context).pushNamed(SignUp.routeName),
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
