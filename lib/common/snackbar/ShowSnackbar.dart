// File: snackbar_helper.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowSnackbar {
  // Static method to show a Snackbar message
  static void showMessage({
    required String title,
    required String message,
    required Color backgroundColor,
    SnackPosition snackPosition = SnackPosition.BOTTOM, // Default position
    Duration duration = const Duration(seconds: 2), // Default duration
    double borderRadius = 8.0, // Default border radius
    Color textColor = Colors.white, // Default text color
    EdgeInsets margin = const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Default margin
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Default padding
  }) {
    Get.snackbar(
      title, // Title of the Snackbar
      message, // Message
      snackPosition: snackPosition, // Position of the Snackbar
      backgroundColor: backgroundColor, // Background color
      colorText: textColor, // Text color
      margin: margin, // Margin around the Snackbar
      padding: padding, // Padding inside the Snackbar
      borderRadius: borderRadius, // Rounds the corners of the Snackbar
      duration: duration, // Duration of the Snackbar
    );
  }
}
