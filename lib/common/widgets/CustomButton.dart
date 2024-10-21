import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height1,
    required this.buttontext,
    required this.backColor,
    required this.textColor,
    this.dark,
    this.onPressed, // Added onPressed callback
  });

  final double height1; // Corrected the type from 'Double' to 'double'
  final String buttontext;

  final Color backColor;
  final Color textColor;
  final bool? dark;
  final VoidCallback? onPressed; // Callback for button press

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Make the button tappable
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: height1,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Text(
              buttontext,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: dark == true ? Colors.white : textColor, // Change color based on dark mode
              ),
            ),
          ],
        ),
      ),
    );
  }
}
