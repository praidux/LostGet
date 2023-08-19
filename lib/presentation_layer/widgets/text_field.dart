import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InputTextField extends StatelessWidget {
  final String textHint;
  final String title;
  final String imageUrl;
  final Function textOnChanged;

  const InputTextField({
    super.key,
    required this.textHint,
    required this.title,
    required this.imageUrl,
    required this.textOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      const SizedBox(
        height: 6,
      ),
      SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: TextField(
          onChanged: (value) {
            textOnChanged(value);
          },
          style: Theme.of(context).textTheme.bodySmall,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                imageUrl,
                height: 10.h,
                width: 10.w,
              ),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            hintText: textHint,

            // floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      )
    ]);
  }
}
