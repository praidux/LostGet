import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PleaseWaitDialog extends StatelessWidget {
  const PleaseWaitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      width: 200.w,
      height: 35.h,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(), // Circular loading indicator
          const SizedBox(width: 16.0),
          Text(
            "Please Wait...",
            style: Theme.of(context).textTheme.bodySmall,
          ), // Text message
        ],
      ),
    );
  }
}
