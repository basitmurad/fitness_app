import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/cupertino.dart';

import '../../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class ProgressContainer extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;

  ProgressContainer({required this.iconPath, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox( height: 2,),

        Image.asset(
          iconPath,
          width: 20, // Adjust the size as needed
          height: 20, // Adjust the size as needed
        ),
        SizedBox( height: 4,),

        SimpleTextWidget(
          text: label,
          fontWeight: FontWeight.w200,
          fontSize: 10,
          fontFamily: 'Poppins', color: AppColor.black,
        ),

        SizedBox( height: 2,),


        SimpleTextWidget(
          text: value,
          fontWeight: FontWeight.w200,
          fontSize: 10,
          fontFamily: 'Poppins', color: AppColor.black,
        ),      ],
    );
  }
}
