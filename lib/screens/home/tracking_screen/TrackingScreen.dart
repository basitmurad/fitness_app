// // import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
// // import 'package:fitness/utils/constants/AppColor.dart';
// // import 'package:fitness/utils/helpers/MyAppHelper.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// //
// // class TrackingScreen extends StatelessWidget {
// //   const TrackingScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     final bool dark = MyAppHelperFunctions.isDarkMode(context);
// //     return Scaffold(
// //       appBar: AppBar(
// //         automaticallyImplyLeading: false,
// //        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back  ,color: dark ? AppColor.white : AppColor.black,)),
// //         title: SimpleTextWidget(text: 'Summary', fontWeight: FontWeight.w500, fontSize: 14, color: dark ? AppColor.white : AppColor.black, fontFamily: 'Poppins'),
// //
// //
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
// //           child: Column(
// //             children: [
// //
// //
// //               Align(
// //                 alignment: Alignment.center,
// //                 child: CustomPaint(
// //                   size: Size(200, 200),
// //                   painter: OpenCirclePainter1(progress: 40),
// //                 ),
// //               )
// //             ],
// //           )
// //         ),
// //       ),
// //     );
// //
// //   }
// // }
// // class OpenCirclePainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     Paint paint = Paint()
// //       ..color = Colors.blue // Circle outline color
// //       ..style = PaintingStyle.stroke // Make it a hollow circle
// //       ..strokeWidth = 16; // Border thickness
// //
// //     // Draw an open arc starting at the bottom (3π/2 radians)
// //     canvas.drawArc(
// //       Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
// //       3 * 3.14159 / 4.6, // Start angle (bottom position)
// //       5 * 3.14159 /3, // Sweep angle (partial circle)
// //       false, // Don't connect to the center
// //       paint,
// //     );
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return false;
// //   }
// // }
// //
// //
// // class OpenCirclePainter1 extends CustomPainter {
// //   final double progress;  // This will hold the progress value (0.0 to 1.0)
// //
// //   OpenCirclePainter1({required this.progress});
// //
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     Paint paint = Paint()
// //       ..color = Colors.blue // Circle outline color
// //       ..style = PaintingStyle.stroke // Make it a hollow circle
// //       ..strokeWidth = 16; // Border thickness
// //
// //     // Calculate the sweep angle based on progress
// //     double sweepAngle = 2 * 3.14159 * progress; // Full circle is 2π radians
// //
// //     // Draw an open arc starting at the bottom (3π/2 radians)
// //     canvas.drawArc(
// //       Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
// //       3 * 3.14159 / 4.6, // Start angle (bottom position)
// //       5 * 3.14159 /3,
// //
// //        // Sweep angle based on progress
// //       false, // Don't connect to the center
// //       paint,
// //     );
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return true; // Repaint when progress changes
// //   }
// // }
// import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
// import 'package:fitness/utils/constants/AppColor.dart';
// import 'package:fitness/utils/helpers/MyAppHelper.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class TrackingScreen extends StatelessWidget {
//   const TrackingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final bool dark = MyAppHelperFunctions.isDarkMode(context);
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           onPressed: () {},
//           icon: Icon(
//             Icons.arrow_back,
//             color: dark ? AppColor.white : AppColor.black,
//           ),
//         ),
//         title: SimpleTextWidget(
//           text: 'Summary',
//           fontWeight: FontWeight.w500,
//           fontSize: 14,
//           color: dark ? AppColor.white : AppColor.black,
//           fontFamily: 'Poppins',
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: CustomPaint(
//                   size: Size(200, 200),
//                   painter: OpenCirclePainter1(steps: 13000, maxSteps: 20000),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class OpenCirclePainter1 extends CustomPainter {
//   final int steps;
//   final int maxSteps;
//
//   OpenCirclePainter1({required this.steps, required this.maxSteps});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Calculate the progress as a fraction (0.0 to 1.0)
//     double progress = steps / maxSteps;
//
//     // Define paints for the background and progress arcs
//     Paint backgroundPaint = Paint()
//       ..color = Colors.grey // Background circle color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 16;
//
//     Paint progressPaint = Paint()
//       ..color = Colors.orange // Progress arc color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 16;
//
//     // Draw the full background arc with a gap (leave a space for open ends)
//     double startAngle = 3 * 3.14159 / 4.6; // Starting from the left
//     double arcLength = 2 * 3.14159 * 0.85; // Slightly less than a full circle for the gap
//     canvas.drawArc(
//       Rect.fromCircle(
//         center: Offset(size.width / 2, size.height / 2),
//         radius: size.width / 2,
//       ),
//       startAngle,
//       arcLength,
//       false,
//       backgroundPaint,
//     );
//
//     // Draw the progress arc with the calculated sweep angle
//     double sweepAngle = arcLength * progress; // Adjust the length of the progress
//     canvas.drawArc(
//       Rect.fromCircle(
//         center: Offset(size.width / 2, size.height / 2),
//         radius: size.width / 2,
//       ),
//       startAngle,
//       sweepAngle,
//       false,
//       progressPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true; // Repaint when progress changes
//   }
// }
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/AppImagePaths.dart';
import '../dashboard_screen/widgets/ProgressContainer.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: dark ? AppColor.white : AppColor.black,
          ),
        ),
        title: SimpleTextWidget(
          text: 'Summary',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: dark ? AppColor.white : AppColor.black,
          fontFamily: 'Poppins',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: CustomPaint(
                  size: Size(200, 200),
                  painter: OpenCirclePainter1(steps: 17000, maxSteps: 20000),
                ),
              ),
              SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              SizedBox(
                width: MyAppHelperFunctions.screenWidth() * 0.95,
                height: 70, // Adjust height as needed

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // Evenly spaced children
                      children: [
                        // Calories Container
                        Container(
                          height: 60,
                          width: 72,
                          decoration: BoxDecoration(
                            color: dark
                                ? AppColor.white.withOpacity(0.1)
                                : AppColor.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: dark
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.1),
                                blurRadius: 8, // Blur radius for the shadow
                                spreadRadius: 2, // Spread radius for the shadow
                                offset: Offset(
                                    0, 4), // Position of the shadow (X, Y)
                              ),
                            ],
                          ),
                          child: ProgressContainer(
                            iconPath: AppImagePaths.kcalicon,
                            label: '320',
                            value: 'kcal',
                          ),
                        ), // Time Container
                        Container(
                          height: 60,
                          width: 72,
                          decoration: BoxDecoration(
                            color: dark
                                ? AppColor.white.withOpacity(0.1)
                                : AppColor.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: dark
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.1),
                                blurRadius: 8, // Blur radius for the shadow
                                spreadRadius: 2, // Spread radius for the shadow
                                offset: Offset(
                                    0, 4), // Position of the shadow (X, Y)
                              ),
                            ],
                          ),
                          child: ProgressContainer(
                            iconPath: AppImagePaths.clock,
                            label: '234', // Show elapsed time
                            value: 'time',
                          ),
                        ),
                        // Steps Container
                        Container(
                          height: 60,
                          width: 72,
                          decoration: BoxDecoration(
                            color: dark
                                ? AppColor.white.withOpacity(0.1)
                                : AppColor.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: dark
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.1),
                                blurRadius: 8, // Blur radius for the shadow
                                spreadRadius: 2, // Spread radius for the shadow
                                offset: Offset(
                                    0, 4), // Position of the shadow (X, Y)
                              ),
                            ],
                          ),
                          child: ProgressContainer(
                            iconPath: AppImagePaths.footstep,
                            label: '4533', // Show steps count
                            value: 'steps',
                          ),
                        ),
                        // Distance Container
                        Container(
                          height: 60,
                          width: 72,
                          decoration: BoxDecoration(
                            color: dark
                                ? AppColor.white.withOpacity(0.1)
                                : AppColor.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: dark
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.1),
                                blurRadius: 8, // Blur radius for the shadow
                                spreadRadius: 2, // Spread radius for the shadow
                                offset: Offset(
                                    0, 4), // Position of the shadow (X, Y)
                              ),
                            ],
                          ),
                          child: ProgressContainer(
                            iconPath: AppImagePaths.location,
                            label: '8.7', // Show miles
                            value: 'miles',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.spaceBtwItems + 10,
              ),
              Container(
                width: MyAppHelperFunctions.screenWidth() * 0.95,
                height: 120, // Adjust height as needed
                decoration: BoxDecoration(
                  color: dark
                      ? AppColor.grey.withOpacity(0.1)
                      : AppColor.grey.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleTextWidget(
                        text: 'This week progress',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: dark ? AppColor.white : AppColor.black,
                        fontFamily: 'Poppins',
                        align: TextAlign.start,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(7, (index) {
                          final dayLabels = [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun'
                          ];
                          final dailySteps = [
                            13000,
                            15000,
                            8000,
                            18000,
                            20000,
                            17500,
                            12000
                          ]; // Sample daily step data
                          final totalSteps = 20000;

                          // Calculate progress based on the 20,000-step goal
                          double progress = dailySteps[index] / totalSteps;

                          return Column(
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomPaint(
                                      size: const Size(26, 26),
                                      painter: CircularProgressPainter(
                                          progress: progress),
                                    ),
                                    Text(
                                      '${(progress * 100).toInt()}%',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: dark
                                            ? AppColor.white
                                            : AppColor.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                dayLabels[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dark ? AppColor.white : AppColor.black,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: MyAppHelperFunctions.screenWidth() * 0.95,
                height: 200, // Adjust height as needed
                decoration: BoxDecoration(
                  color: dark
                      ? AppColor.grey.withOpacity(0.1)
                      : AppColor.grey.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SimpleTextWidget(
                            text: 'Overall Progress',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: dark ? AppColor.white : AppColor.black,
                            fontFamily: 'Poppins',
                            align: TextAlign.start,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: AppSizes.spaceBtwItems + 20,
                            ),
                            Image(
                              image: AssetImage(
                                AppImagePaths.footicon,
                              ),
                              width: 24, // Define the width of the image
                              height: 24,
                            ),
                            SimpleTextWidget(
                              text: '34534534',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: dark ? AppColor.white : AppColor.black,
                              fontFamily: 'Poppins',
                              align: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.spaceBtwItems -10,
                        ),
                        SimpleTextWidget(
                          text: 'Total steps of all time.',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: dark ? AppColor.white : AppColor.black,
                          fontFamily: 'Poppins',
                          align: TextAlign.start,
                        ),
                        SizedBox(
                          height: AppSizes.spaceBtwInputFields,
                        ),
                        Container(width: MyAppHelperFunctions.screenWidth(),

                        height: 1,
                        color: Colors.grey,),
                        SizedBox(
                          height: AppSizes.spaceBtwInputFields,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // Evenly spaced children
                          children: [
                            // Calories Container
                            Container(
                              height: 60,
                              width: 72,
                              decoration: BoxDecoration(
                                color: dark
                                    ? AppColor.white.withOpacity(0.1)
                                    : AppColor.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    // Blur radius for the shadow
                                    spreadRadius: 2,
                                    // Spread radius for the shadow
                                    offset: Offset(
                                        0, 4), // Position of the shadow (X, Y)
                                  ),
                                ],
                              ),
                              child: ProgressContainer(
                                iconPath: AppImagePaths.kcalicon,
                                label: '320',
                                value: 'kcal',
                              ),
                            ), // Time Container
                            Container(
                              height: 60,
                              width: 72,
                              decoration: BoxDecoration(
                                color: dark
                                    ? AppColor.white.withOpacity(0.1)
                                    : AppColor.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    // Blur radius for the shadow
                                    spreadRadius: 2,
                                    // Spread radius for the shadow
                                    offset: Offset(
                                        0, 4), // Position of the shadow (X, Y)
                                  ),
                                ],
                              ),
                              child: ProgressContainer(
                                iconPath: AppImagePaths.clock,
                                label: '234', // Show elapsed time
                                value: 'time',
                              ),
                            ),
                            // Steps Container
                            Container(
                              height: 60,
                              width: 72,
                              decoration: BoxDecoration(
                                color: dark
                                    ? AppColor.white.withOpacity(0.1)
                                    : AppColor.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    // Blur radius for the shadow
                                    spreadRadius: 2,
                                    // Spread radius for the shadow
                                    offset: Offset(
                                        0, 4), // Position of the shadow (X, Y)
                                  ),
                                ],
                              ),
                              child: ProgressContainer(
                                iconPath: AppImagePaths.footstep,
                                label: '4533', // Show steps count
                                value: 'steps',
                              ),
                            ),
                            // Distance Container
                            Container(
                              height: 60,
                              width: 72,
                              decoration: BoxDecoration(
                                color: dark
                                    ? AppColor.white.withOpacity(0.1)
                                    : AppColor.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    // Blur radius for the shadow
                                    spreadRadius: 2,
                                    // Spread radius for the shadow
                                    offset: Offset(
                                        0, 4), // Position of the shadow (X, Y)
                                  ),
                                ],
                              ),
                              child: ProgressContainer(
                                iconPath: AppImagePaths.location,
                                label: '8.7', // Show miles
                                value: 'miles',
                              ),
                            ),
                          ],
                        ),

                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      ..strokeCap = StrokeCap.round; // Rounded end for the background arc

    Paint progressPaint = Paint()
      ..color = Colors.orange // Progress arc color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round; // Rounded end for the progress arc

    // Define the start angle and arc length to leave a gap
    double startAngle = 3 * 3.14159 / 4.6; // Starting from the left
    double arcLength =
        2 * 3.14159 * 0.85; // Slightly less than a full circle for the gap

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
    double sweepAngle =
        arcLength * progress; // Adjust the length of the progress arc
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint when progress changes
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      0,
      2 * 3.14159,
      false,
      backgroundPaint,
    );

    double sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      -3.14159 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
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
