import 'package:flutter/material.dart';
import 'package:lost_get/constants/colors.dart';

Widget createButton(context, String title) {
  return Container(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(title),
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(15)),
      ));
}
