import 'package:flutter/cupertino.dart';
import '../../../../../utils/constants/AppColor.dart';
import '../../../../../utils/constants/AppImagePaths.dart';
import '../../../../../utils/constants/AppString.dart';
import '../../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class IconWithTextWidget extends StatelessWidget {
  const IconWithTextWidget({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(
            AppImagePaths.logo,
          ),
          height: 30,
          width: 30,
        ),
        SizedBox(
          width: 4,
        ),
        SimpleTextWidget(
            text: AppStrings.textChalpro,
            fontWeight: FontWeight.w300,
            fontSize: 14,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins')
      ],
    );
  }
}
