import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';

class LoginDividerWidget extends StatelessWidget {
  const LoginDividerWidget({
    super.key, required this.dark,
  });
  final bool dark;


  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          'OR CONTINUE WITH',
          style: Theme.of(context).textTheme.bodySmall!.copyWith( fontFamily: 'Poppins' , color: dark ? AppColor.white :AppColor.textColor ,fontWeight: FontWeight.w700),
        ),

      ],
    );
  }
}
