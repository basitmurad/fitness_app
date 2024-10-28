import 'package:flutter/cupertino.dart';

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String iconPath;
  final String selectedIconPath;

  const CustomRadioButton({super.key,
    required this.isSelected,
    required this.onTap,
    required this.iconPath,
    required this.selectedIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        isSelected ? selectedIconPath : iconPath,
        height: 20, // Adjust size as needed
        width: 20,  // Adjust size as needed
        fit: BoxFit.cover, // Adjust fit as needed
      ),
    );
  }
}
