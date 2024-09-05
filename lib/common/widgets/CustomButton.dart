import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/AppColor.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.height1, required this.buttontext,
  });

  final double height1;  // Corrected the type from 'Double' to 'double'
  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: height1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Text(
        buttontext,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColor.orangeColor,
        ),
      ),
    );
  }
}
