import 'package:flutter/cupertino.dart';

import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppSizes.dart';
import '../../../../utils/constants/AppString.dart';
import '../../exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'TextWithDot.dart';

class TipsWidgets extends StatelessWidget {
  const TipsWidgets({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const SizedBox(
          height: AppSizes.inputFieldRadius + 10,
        ),
        SimpleTextWidget(
            text: AppStrings.textTips,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins'),
        const SizedBox(
          height: AppSizes.inputFieldRadius - 5,
        ),
        TextWithDot(
          dark: dark,
          text: AppStrings.textTips1,
        ),
        const SizedBox(
          height: 12,
        ),
        TextWithDot(
          dark: dark,
          text: AppStrings.textTips2,
        ),
        const SizedBox(
          height: 12,
        ),
        TextWithDot(
          dark: dark,
          text: AppStrings.textTips3,
        ),
        const SizedBox(
          height: 12,
        ),
        TextWithDot(
          dark: dark,
          text: AppStrings.textTips4,
        ),
      ],
    );
  }
}
