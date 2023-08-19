import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/colors.dart';

Widget headingText(context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.titleLarge,
  );
}

Widget getTextFields(context, String textHint, String title, String imageUrl) {
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

Widget getPasswordFields(context, String textHint, String title,
    String imageUrl, bool isHidden, Function toggleEye) {
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
          suffixIcon: IconButton(
              onPressed: () => toggleEye(),
              icon: isHidden
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
        obscureText: isHidden,
      ),
    )
  ]);
}

Widget createCheckboxNecessaryItems(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Row(
          children: [
            const SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: false,
                onChanged: null,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              'Remember me?',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
      const Text(
        "Forgot password?",
        style: TextStyle(
            color: AppColors.primaryColor, fontWeight: FontWeight.w600),
      ),
    ],
  );
}
