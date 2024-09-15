// import 'package:fitness/utils/constants/AppColor.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ButtonWidget extends StatelessWidget {
//   const   ButtonWidget({
//     super.key,
//     required this.dark,
//     required this.onPressed, // Callback for button press
//     required this.buttonText, this.backColor, // Text for the button
//   });
//
//   final bool dark;
//   final Color? backColor;
//   final VoidCallback onPressed; // Callback function when the button is pressed
//   final String buttonText; // Text to display on the button
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//
//       onPressed: onPressed, // Use the passed callback
//       style: ElevatedButton.styleFrom(
//
//         fixedSize: const Size(double.infinity, 46), // Full width of its parent
//         padding: const EdgeInsets.only(left: 8,right: 8,top: 6 ,bottom: 6), // Padding inside the button
//         shape: RoundedRectangleBorder(
//
//
// side: BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(6),
//
//           // Radius: 6px
//         ),
//       ),
//       child: Text(
//         buttonText, // Use the passed button text
//         style: Theme.of(context).textTheme.titleSmall?.copyWith(
//           height: 1.5, // Line height: 24px (16px * 1.5)
//           color: dark ? Colors.white : Colors.white, // Text color
//           fontSize: 15, // Font size
//           fontFamily: "Poppins", // Font family
//         ),
//       ),
//     );
//   }
// }
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.dark,
    required this.onPressed, // Callback for button press
    required this.buttonText,
    this.backColor, // Background color for the button
    this.enabled = true, // Whether the button is enabled
  });

  final bool dark;
  final Color? backColor;
  final VoidCallback onPressed; // Callback function when the button is pressed
  final String buttonText; // Text to display on the button
  final bool enabled; // Whether the button is enabled

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.1, // Set opacity based on whether the button is enabled
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null, // Use the passed callback if enabled
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 46), backgroundColor: backColor ?? AppColor.orangeColor, // Full width of its parent
          padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6), // Background color of the button
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(6), // Radius: 6px
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
      ),
    );
  }
}
