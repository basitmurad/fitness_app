import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.onSuffixIconPressed,
    this.isPassword,
    this.obscureText,
    this.onObscureTextChanged, this.hintText,
  });

  final TextEditingController controller;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool? isPassword;
  final bool? obscureText;
  final VoidCallback? onObscureTextChanged;
  final String? hintText ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword == true ? obscureText ?? true : false, // Toggle obscuring based on isPassword and obscureText



      decoration: InputDecoration(
        hintText: hintText, // Set the hintText here

        prefixIcon: prefixIcon != null
            ? SizedBox(
          width: 24, // Set the width of the prefix icon
          height: 24, // Set the height of the prefix icon
          child: prefixIcon,
        )
            : null,        suffixIcon: isPassword == true
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
          borderSide: BorderSide(
            width: 0.94,
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.77),
          borderSide: BorderSide(
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
    );
  }
}
