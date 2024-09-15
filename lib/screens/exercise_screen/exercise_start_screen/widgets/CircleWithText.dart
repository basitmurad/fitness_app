import 'package:flutter/material.dart';

class CircleWithText extends StatelessWidget {
  final String text;
  final double size;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final double borderWidth;

  const CircleWithText({
    super.key,
    required this.text,
    this.size = 100.0,
    this.borderColor = Colors.blue,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.black,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize:16, // Adjust text size relative to circle size
          ),
        ),
      ),
    );
  }
}
