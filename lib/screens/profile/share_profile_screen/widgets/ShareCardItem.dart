import 'package:flutter/material.dart';
import '../../../../../utils/constants/AppColor.dart';
import '../../../exercise_screen/screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class ShareCardItem extends StatelessWidget {
  const ShareCardItem({
    super.key,
    required this.text,
    required this.iconData,
  });

  final String text;
  final IconData iconData; // Change type to IconData

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
      height: 75,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: Colors.black, size: 20), // Create Icon widget here
          SimpleTextWidget(
            text: text,
            fontWeight: FontWeight.w300,
            fontSize: 12,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ],
      ),
    );
  }
}
