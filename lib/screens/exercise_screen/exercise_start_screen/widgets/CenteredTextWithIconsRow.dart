import 'package:flutter/material.dart';

class CenteredTextWithIconsRow extends StatelessWidget {
  final String text;
  final String text1;
  final String leftIcon;
  final String rightIcon;
  final Color textColor;
  final VoidCallback onLeftIconPressed;
  final VoidCallback onRightIconPressed;

  const CenteredTextWithIconsRow({
    super.key,
    required this.text,
    required this.text1,
    required this.leftIcon,
    required this.rightIcon,
    required this.textColor,
    required this.onLeftIconPressed,
    required this.onRightIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0), // Add padding if needed
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
            ),
            padding: const EdgeInsets.all(8),

            child: GestureDetector(
              onTap: onLeftIconPressed,
              child: Transform.rotate(
                angle: 0,
                child: Image(
                  height: 28,
                  width: 28,
                  image: AssetImage(leftIcon),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: textColor,
              fontFamily: 'Poppins',
            ),
          ),
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
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: onRightIconPressed,
              child: Transform.rotate(
                angle: 0,
                child: Image(
                  height: 28,
                  width: 28,
                  image: AssetImage(rightIcon), // Changed to rightIcon
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
