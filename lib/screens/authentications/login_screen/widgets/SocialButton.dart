import 'package:flutter/material.dart';
import '../../../../utils/constants/AppImagePaths.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(



      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          width: screenWidth * 0.2,
          height: 50.0,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
          ),



          child: Center(
            child: Image.asset(AppImagePaths.googleIcon),
          ),
        ),
        const SizedBox(width: 40), // Adjust horizontal spacing
      ],
    );
  }
}
