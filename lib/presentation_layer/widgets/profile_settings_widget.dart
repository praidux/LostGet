import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget createListTile(String title, String subtitle, String leadingIcon,
    Function handleFunction) {
  return InkWell(
    onTap: () {
      handleFunction();
    },
    child: Column(children: [
      ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        leading: SvgPicture.asset(leadingIcon),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal),
        ),
        trailing: SizedBox(
            child: SvgPicture.asset(
          'assets/icons/arrow-right.svg',
          height: 10.h,
          width: 10.w,
        )),
      ),
      Divider(
        color: Colors.grey.withOpacity(0.2),
        height: 1,
        thickness: 1,
      )
    ]),
  );
}
