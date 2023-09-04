import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChangePhoneNumberVerifiedScreen extends StatelessWidget {
  const ChangePhoneNumberVerifiedScreen({super.key});
  static const routeName = '/change_phone_number_verified';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            ClipPath(
              clipper: BumpyClipper(),
              child: Container(
                color: Colors.blue,
                height: 200,
              ),
            )
          ],
        )
      ]),
    );
  }
}

class BumpyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);

    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
