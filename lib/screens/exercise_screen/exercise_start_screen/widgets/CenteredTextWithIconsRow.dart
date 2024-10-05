
import 'package:flutter/material.dart';

class CenteredTextWithIconsRow extends StatelessWidget {
  final String text;
  final String text1;
  final String leftIcon;
  final String rightIcon;
  final Color textColor;
  final VoidCallback onLeftIconPressed;
  final VoidCallback onRightIconPressed;
  final double leftIconAngle;  // New angle parameter for the left icon
  final double rightIconAngle; // New angle parameter for the right icon

  const CenteredTextWithIconsRow({
    super.key,
    required this.text,
    required this.text1,
    required this.leftIcon,
    required this.rightIcon,
    required this.textColor,
    required this.onLeftIconPressed,
    required this.onRightIconPressed,
    required this.leftIconAngle,  // Initialize in the constructor
    required this.rightIconAngle, // Initialize in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0), // Add padding if needed
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left Icon
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: onLeftIconPressed,
              child: Transform.rotate(
                angle: leftIconAngle, // Use the passed leftIconAngle
                child: Image(
                  height: 28,
                  width: 28,
                  image: AssetImage(leftIcon),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Text 1
          Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: textColor,
              fontFamily: 'Poppins',
            ),
          ),

          // Text 2
          Text(
            text1,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: textColor,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(width: 10),

          // Right Icon
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: onRightIconPressed,
              child: Transform.rotate(
                angle: rightIconAngle, // Use the passed rightIconAngle
                child: Image(
                  height: 28,
                  width: 28,
                  image: AssetImage(rightIcon),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
