 import 'package:flutter/material.dart';

import '../../../../../utils/constants/AppColor.dart';

  class CustomIconButton extends StatelessWidget {
    const CustomIconButton({
      Key? key,
      required this.iconData,
      required this.dark,
      required this.onPressed,
    }) : super(key: key);

    final bool dark;
    final IconData iconData;
    final VoidCallback onPressed;

    @override
    Widget build(BuildContext context) {
      return Container(
        height: 24,
        width: 24,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.2),
        ),
        child: IconButton(
          icon: Icon(
            iconData,
            color: dark ? AppColor.white : AppColor.black,
            size: 18,
          ),
          onPressed: onPressed,
          padding: EdgeInsets.zero, // Ensure no extra padding
          constraints: const BoxConstraints(), // Remove constraints
        ),
      );
    }
  }
