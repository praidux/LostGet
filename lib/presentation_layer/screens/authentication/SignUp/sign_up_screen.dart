import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lost_get/presentation_layer/widgets/button.dart';
import '../../../widgets/authentication_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const routeName = '/sign_up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              headingText(context, 'Sign Up'),
              SizedBox(
                height: 18.h,
              ),
              // getTextFields(context, 'Your First Name', 'First Name',
              //     'assets/icons/profile.svg', () {}),
              // SizedBox(
              //   height: 9.h,
              // ),
              // getTextFields(context, 'Your Last Name', 'Last Name',
              //     'assets/icons/profile.svg', () {}),
              // SizedBox(
              //   height: 9.h,
              // ),
              // getTextFields(context, 'Your Email Address', 'E-mail',
              //     'assets/icons/mail.svg', () {}),
              SizedBox(
                height: 9.h,
              ),
              // getPasswordFields(
              //   context,
              //   'Your Password',
              //   'Password',
              //   'assets/icons/lock.svg',
              //   _isHidden,
              //   _togglePasswordView,
              // ),
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
                          recognizer: TapGestureRecognizer()..onTap = () {})
                    ]),
              ),
              SizedBox(
                height: 20.h,
              ),
              createButton(context, 'Register Now'),
              SizedBox(
                height: 20.h,
              ),
              createRichTextForLoginSignUp(
                  context, 'Already a member? ', 'Login', () {}),
            ]),
          ),
        ),
      ),
    );
  }
}
