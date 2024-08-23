import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/AppColor.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.onSuffixIconPressed,
    this.isPassword,
    this.obscureText,
    this.onObscureTextChanged,
    this.hintText,
    required this.dark,
    this.headerText,
    this.headerStyle,
    this.headerFontWeight,
    this.headerFontFamily,
    this.hintTextColor, this.focusNode, // New parameter for hint text color
  });

  final TextEditingController controller;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool? isPassword;
  final bool? obscureText;
  final VoidCallback? onObscureTextChanged;
  final String? hintText;
  final bool dark;
  final String? headerText;
  final TextStyle? headerStyle;
  final FontWeight? headerFontWeight;
  final String? headerFontFamily;
  final Color? hintTextColor;
  final FocusNode? focusNode ;// New parameter for hint text color

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerText != null) ...[
          Text(
            headerText!,
            style: headerStyle ??
                Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: dark ? AppColor.white : AppColor.textColor,
                  fontSize: 14,
                  fontWeight: headerFontWeight ?? FontWeight.w700,
                  fontFamily: headerFontFamily ?? 'Manrope',
                ),
          ),
          const SizedBox(height: AppSizes.inputFieldRadius - 6),
        ],
        TextFormField(
          focusNode: focusNode,
          controller: controller,
          obscureText: isPassword == true ? obscureText ?? true : false, // Toggle obscuring based on isPassword and obscureText
          decoration: InputDecoration(
            hintText: hintText, // Set the hintText here
            hintStyle: TextStyle(color: hintTextColor ?? AppColor.textColor1), // Set hint text color
            prefixIcon: prefixIcon != null
                ? SizedBox(
              width: 24, // Set the width of the prefix icon
              height: 24, // Set the height of the prefix icon
              child: prefixIcon,
            )
                : null,
            suffixIcon: isPassword == true
                ? GestureDetector(
              onTap: onObscureTextChanged, // Handle suffix icon click
              child: Icon(
                size: 24,
                obscureText ?? true ? Icons.visibility_off : Icons.visibility,
              ),
            )
                : suffixIcon != null
                ? GestureDetector(
              onTap: onSuffixIconPressed,
              child: suffixIcon,
            )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.77),
              borderSide: const BorderSide(
                width: 0.94,
                color: Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.77),
              borderSide: const BorderSide(
                width: 0.94,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.77),
              borderSide: BorderSide(
                width: 0.94,
                color: Theme.of(context).primaryColor,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 12.0,
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
