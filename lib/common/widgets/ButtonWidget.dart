import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.dark,
    required this.onPressed, // Callback for button press
    required this.buttonText, // Text for the button
  });

  final bool dark;
  final VoidCallback onPressed; // Callback function when the button is pressed
  final String buttonText; // Text to display on the button

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Use the passed callback
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.lightBlue,
        fixedSize: const Size(double.infinity, 48), // Full width of its parent
        padding: const EdgeInsets.all(10), // Padding inside the button
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(6),

          // Radius: 6px
        ),
      ),
      child: Text(
        buttonText, // Use the passed button text
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          height: 1.5, // Line height: 24px (16px * 1.5)
          color: dark ? Colors.white : Colors.white, // Text color
          fontSize: 15, // Font size
          fontFamily: "Poppins", // Font family
        ),
      ),
    );
  }
}
