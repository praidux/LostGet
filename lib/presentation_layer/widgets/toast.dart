import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lost_get/constants/colors.dart';

createToast(
    {required description,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black}) {
  Fluttertoast.showToast(
    msg: description,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    textColor: textColor,
    backgroundColor: backgroundColor,
    timeInSecForIosWeb: 2,
    fontSize: 14.sp,
  );
}
