import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;              // Current state of the checkbox
  final String checkedAssetPath;     // Path to the checked state asset
  final String uncheckedAssetPath;   // Path to the unchecked state asset
  final double iconSize;             // Size of the icon
  final VoidCallback onTap;          // Callback for when the checkbox is tapped
  final bool dark;                   // Dark mode flag

  CustomCheckbox({
    required this.isChecked,
    required this.checkedAssetPath,
    required this.uncheckedAssetPath,
    required this.iconSize,
    required this.onTap,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the controller's method on tap
      child: Image.asset(
        isChecked ? checkedAssetPath : uncheckedAssetPath,
        color: dark ? Colors.white : Colors.black, // Example colors
        width: iconSize,
        height: iconSize,
      ),
    );
  }
}
