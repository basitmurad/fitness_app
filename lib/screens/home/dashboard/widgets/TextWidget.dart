import 'package:flutter/cupertino.dart';

import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppString.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.workouts,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: dark ? AppColor.white : AppColor.black),
        ),
        const SizedBox(height: 4), // Space between text and bar
        Container(
          width: 50,
          height: 2,
          color: dark ? AppColor.white : AppColor.lightBlue,
        ),
      ],
    );
  }
}
