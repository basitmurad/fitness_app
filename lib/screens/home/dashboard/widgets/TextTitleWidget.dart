import 'package:flutter/cupertino.dart';
import '../../../../utils/constants/AppColor.dart';

class TextTitleWidget extends StatelessWidget {
  const TextTitleWidget({
    super.key,
    required this.dark, required this.title,
  });

  final bool dark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
