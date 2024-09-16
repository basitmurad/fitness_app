  // import 'package:flutter/cupertino.dart';
  // import 'package:flutter/material.dart';
  //
  // import '../../../../utils/constants/AppColor.dart';
  //
  // class CustomIconButton extends StatelessWidget {
  //   const CustomIconButton({
  //     super.key,
  //     required this.iconData,
  //     required this.dark, required this.onPressed,
  //   });
  //
  //
  //
  //   final bool dark;
  //
  //   final IconData iconData;
  //   final VoidCallback onPressed;
  //
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Container(
  //       height: 24,
  //       width: 24,
  //       padding: EdgeInsets.zero,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.grey.withOpacity(0.2),
  //       ),
  //       child: Center(
  //         child: Icon(
  //           iconData, // Corrected here
  //           color: dark ? AppColor.white : AppColor.black, // Icon color
  //           size: 18, // Icon size
  //         ),
  //       ),
  //     );
  //   }
  // }
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import '../../../../utils/constants/AppColor.dart'; // Adjust import path as necessary

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
