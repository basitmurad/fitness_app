import 'package:flutter/material.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppString.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [


        Text(
          AppStrings.hello,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: dark ? AppColor.white : AppColor.textColor),
          textAlign: TextAlign.start,
        ),
        Text(
          AppStrings.fitnessTitans,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: dark ? AppColor.white : AppColor.textColor),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
