import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pedometer/pedometer.dart';

void backgroundService() {
  WidgetsFlutterBinding.ensureInitialized();

  // Listen to step count updates from the static stepCountStream
  Pedometer.stepCountStream.listen((StepCount event) {
    int steps = event.steps;
    double miles = steps * 0.000473484; // Convert steps to miles

    // Handle the step count (e.g., store it, print it, etc.)
    print("Steps: $steps");
    print("Miles: $miles");

    // You can save this data to shared preferences or a database
  }, onError: (error) {
    print("Error: $error");
  });

  // Keep the service running indefinitely
  Timer.periodic(Duration(seconds: 5), (timer) {
    // Additional tasks can be handled here if needed
  });
}
