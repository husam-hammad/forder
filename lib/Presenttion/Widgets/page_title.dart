import 'package:flutter/cupertino.dart';

import '../../Constants/textstyles.dart';

Widget pageTitle(title, other) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.pinkboldTopPage,
        ),
        Row()
      ],
    ),
  );
}
