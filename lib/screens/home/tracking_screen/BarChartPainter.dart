import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue // Bar color
      ..style = PaintingStyle.fill;

    double barWidth = 30;
    double spaceBetweenBars = 10;
    double maxHeight = size.height;
    List<double> values = [120, 150, 180, 90, 160]; // Your data values
    double maxValue = values.reduce((curr, next) => curr > next ? curr : next);

    for (int i = 0; i < values.length; i++) {
      double barHeight = (values[i] / maxValue) * maxHeight;
      double xPosition = i * (barWidth + spaceBetweenBars);
      double yPosition = maxHeight - barHeight;

      // Draw each bar
      canvas.drawRect(
        Rect.fromLTWH(xPosition, yPosition, barWidth, barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
