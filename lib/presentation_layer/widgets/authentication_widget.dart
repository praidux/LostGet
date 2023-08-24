import 'package:flutter/material.dart';

import '../../common/constants/colors.dart';

Widget headingText(context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.titleLarge,
  );
}

Widget createCheckboxNecessaryItems(context) {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        "Forgot password?",
        style: TextStyle(
            color: AppColors.primaryColor, fontWeight: FontWeight.w600),
      ),
    ],
  );
}

Widget createRichTextForLoginSignUp(
    context, String description, String whereTo, Function navigateTo) {
  // final state = context.read<SignInBloc>().state;
  return Center(
    child: RichText(
      text: TextSpan(
        text: description,
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          WidgetSpan(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => navigateTo(),
                child: Text(
                  whereTo,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
