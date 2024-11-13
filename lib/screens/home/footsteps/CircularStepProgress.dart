import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'StepController.dart';

class CircularStepProgress extends StatelessWidget {
  final StepController stepController = Get.find();
  final int goal = 20000;

   CircularStepProgress({super.key}); // Set your daily step goal to 20,000

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double currentDayProgress = (stepController.stepCount.value / goal).clamp(0.0, 1.0);
      int stepsToday = stepController.stepCount.value; // Today's steps
      String percentage = (currentDayProgress * 100).toStringAsFixed(1); // Percentage for today

      // Sample data for daily steps for the last 7 days (replace with actual data)

      // Get the current day index (0 = Monday, 6 = Sunday)
      int currentDayIndex = (DateTime.now().weekday - 1) % 7; // Normalize to 0-6 (Monday to Sunday)

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Main Circular Progress Indicator for today's steps
          Container(
            width: 200, // Width of the main circle
            height: 200, // Height of the main circle
            child: CircularProgressIndicator(
              value: currentDayProgress,
              strokeWidth: 15, // Thicker stroke width for better visibility
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          SizedBox(height: 10),
          // Display today's steps and target steps inside the main circle
          Text(
            '$stepsToday', // Display today's step count
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          Text(
            'of $goal', // Display target step goal
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '$percentage%', // Display percentage of today's goal reached
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          // Row to display the steps for each day of the week
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              for (int i = 0; i < 7; i++) // Create a small circle for each day
                _buildDayCircle(
                  day: _getDayName(i), // Get day name
                  steps: 9, // Get corresponding steps
                  isCurrentDay: i == currentDayIndex, // Check if current day
                ),
            ],
          ),
        ],
      );
    });
  }

  // Helper method to build a small circle for each day
  Widget _buildDayCircle({required String day, required int steps, required bool isCurrentDay}) {
    double dayProgress = (steps / 20000).clamp(0.0, 1.0); // Calculate progress for the day
    Color circleColor = isCurrentDay ? Colors.green : Colors.blue; // Highlight current day

    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            value: dayProgress,
            strokeWidth: 5,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(circleColor), // Different color for current day
          ),
        ),
        SizedBox(height: 5),
        Text(
          '$steps', // Display step count for the day
          style: TextStyle(color: Colors.black, fontSize: 12),
          textAlign: TextAlign.center,
        ),
        Text(day, style: TextStyle(fontSize: 12)), // Display day name
      ],
    );
  }

  // Helper method to get the day name based on the index
  String _getDayName(int index) {
    switch (index) {
      case 0: return 'Mon';
      case 1: return 'Tue';
      case 2: return 'Wed';
      case 3: return 'Thu';
      case 4: return 'Fri';
      case 5: return 'Sat';
      case 6: return 'Sun';
      default: return '';
    }
  }
}
