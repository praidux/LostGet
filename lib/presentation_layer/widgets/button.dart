import 'package:flutter/material.dart';
import 'package:lost_get/constants/colors.dart';

class CreateButton extends StatelessWidget {
  final String title;
  final VoidCallback? handleButton;
  const CreateButton({
    super.key,
    required this.title,
    required this.handleButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: ElevatedButton(
          onPressed: handleButton,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.all(15)),
          child: Text(title),
        ));
  }
}
