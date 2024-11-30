import 'package:flutter/cupertino.dart';
import '../../../../../utils/constants/AppColor.dart';
import '../../../../../utils/constants/AppSizes.dart';
import '../../../../../utils/constants/AppString.dart';
import '../../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class SelectWidgets extends StatelessWidget {
  const SelectWidgets({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SimpleTextWidget(
            text: AppStrings.textChallengeTitle,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins'),
        const SizedBox(
          height: AppSizes.inputFieldRadius,
        ),
        SimpleTextWidget(
            lineSpacing: 2,
            text: AppStrings.textChallengeSubtitle,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins'),
      ],
    );
  }
}
