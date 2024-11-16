import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpenCirclePainter1 extends CustomPainter {
  final int steps;
  final int maxSteps;

  OpenCirclePainter1({required this.steps, required this.maxSteps});

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the progress as a fraction (0.0 to 1.0)
    double progress = steps / maxSteps;

    // Define paints with rounded caps for the background and progress arcs
    Paint backgroundPaint = Paint()
      ..color = Colors.grey // Background circle color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = Colors.orange // Progress arc color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    // Define the start angle and arc length to leave a gap
    double startAngle = 3 * 3.14159 / 4.6; // Starting from the left
    double arcLength = 2 * 3.14159 * 0.85; // Slightly less than a full circle

    // Draw the full background arc with rounded edges
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      startAngle,
      arcLength,
      false,
      backgroundPaint,
    );

    // Draw the progress arc with the calculated sweep angle and rounded edges
    double sweepAngle = arcLength * progress;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );

    // Draw the inner colored circle
    Paint innerCirclePaint = Paint()
      ..color =
      Colors.blue[50]!; // Set a light background color inside the circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 20,
      // Adjust the radius for padding inside the outer circle
      innerCirclePaint,
    );

    // Draw text for total steps and today's steps
    TextPainter textPainter1 = TextPainter(
      text: TextSpan(
        text: 'Total Steps:\n$maxSteps',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter1.layout();
    textPainter1.paint(
      canvas,
      Offset(
        (size.width - textPainter1.width) / 2,
        (size.height - textPainter1.height) / 2 - 20,
      ),
    );

    TextPainter textPainter2 = TextPainter(
      text: TextSpan(
        text: 'Today\'s Steps:\n$steps',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter2.layout();
    textPainter2.paint(
      canvas,
      Offset(
        (size.width - textPainter2.width) / 2,
        (size.height - textPainter2.height) / 2 + 20,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint when progress changes
  }
}
