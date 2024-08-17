import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/AppImagePaths.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          width: 60.0,
          height: 60.0,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white, // Background color inside the circle
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey, // Stroke color
              width: 2.0, // Stroke width
            ),
          ),
          child: Image.asset(AppImagePaths.googleIcon),
        ),
        const SizedBox(width: 10),
        Container(
          width: 60.0,
          height: 60.0,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white, // Background color inside the circle
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey, // Stroke color
              width: 2.0, // Stroke width
            ),
          ),
          child: Image.asset(AppImagePaths.googleIcon),
        ),

      ],
    );
  }
}
