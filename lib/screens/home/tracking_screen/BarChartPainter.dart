//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class BarChartPainter extends CustomPainter {
//   final List<int> values;
//   final List<String> labels;
//
//   BarChartPainter({required this.values, required this.labels});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.blue // Bar color
//       ..style = PaintingStyle.fill;
//
//     double barWidth = 30;
//     double spaceBetweenBars = 20;
//     double maxHeight = size.height;
//     double maxValue = values.reduce((curr, next) => curr > next ? curr : next) as double;
//
//     for (int i = 0; i < values.length; i++) {
//       double barHeight = (values[i] / maxValue) * maxHeight;
//       double xPosition = i * (barWidth + spaceBetweenBars);
//       double yPosition = maxHeight - barHeight;
//
//       // Draw each bar
//       canvas.drawRect(
//         Rect.fromLTWH(xPosition, yPosition, barWidth, barHeight),
//         paint,
//       );
//
//       // Draw labels below the bars
//       TextPainter textPainter = TextPainter(
//         text: TextSpan(
//           text: labels[i],
//           style: TextStyle(color: Colors.black, fontSize: 12),
//         ),
//         textDirection: TextDirection.ltr,
//       );
//       textPainter.layout();
//       textPainter.paint(canvas, Offset(xPosition + (barWidth / 2) - (textPainter.width / 2), maxHeight + 5));
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarChartPainter extends CustomPainter {
  final List<int> values;
  final List<String> labels;

  BarChartPainter({required this.values, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue // Bar color
      ..style = PaintingStyle.fill;

    double barWidth = 30;
    double spaceBetweenBars = 20;
    double maxHeight = size.height;

    // Find max value to scale the bars accordingly
    double maxValue = values.reduce((curr, next) => curr > next ? curr : next).toDouble();

    for (int i = 0; i < values.length; i++) {
      double barHeight = (values[i] / maxValue) * maxHeight;
      double xPosition = i * (barWidth + spaceBetweenBars);
      double yPosition = maxHeight - barHeight;

      // Draw each bar
      canvas.drawRect(
        Rect.fromLTWH(xPosition, yPosition, barWidth, barHeight),
        paint,
      );

      // Draw labels below the bars
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(xPosition + (barWidth / 2) - (textPainter.width / 2), maxHeight + 5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarChartWidget extends StatelessWidget {
  final List<int> values;
  final List<String> labels;

  BarChartWidget({required this.values, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Set the height of the chart
      width: double.infinity, // Make the chart take full width
      child: CustomPaint(
        painter: BarChartPainter(values: values, labels: labels),
      ),
    );
  }
}
