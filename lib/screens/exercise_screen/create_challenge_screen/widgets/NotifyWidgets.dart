import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppImagePaths.dart';
import '../../exercise_detail_screen/widgets/SimpleTextWidget.dart';

class NotifyWidgets extends StatelessWidget {
  const NotifyWidgets({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            // Your onPressed code here
          },
          icon: Image.asset(
            AppImagePaths.notifyIcon, // Path to your custom icon
            width: 18.0, // Set desired width
            height: 18.0, // Set desired height
          ),
        ),
        SimpleTextWidget(
            text: 'Notify me',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: "Poppins")
      ],
    );
  }
}
