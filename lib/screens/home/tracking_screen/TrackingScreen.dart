import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/home/tracking_screen/widgets/CircularProgressPainter.dart';
import 'package:fitness/screens/home/tracking_screen/widgets/OpenCirclePainter1.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../exercise_screen/screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import '../dashboard_screen/widgets/ProgressContainer.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key, required this.dayName});

  final String dayName; // Pass the day name to the screen (e.g., "Monday")

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  int steps = 0;
  double caloriesBurned = 0.0;
  int timeTracked = 0;
  bool isLoading = true;
  Map<String, int> weeklySteps = {}; // Store weekly steps data
  var weeklyTotalSteps;
  var weeklyTotalMiles;
  var weeklyTotalKcal;
  late int totalStepsForAllTime;

  @override
  void initState() {
    super.initState();

    _fetchWeeklyData();
    _fetchTrackingData();
    _checkAndUpdateAllTimeTracking();
  }

  Future<void> _fetchTrackingData() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    String dayName = widget.dayName;

    try {
      DatabaseReference trackingRef =
          FirebaseDatabase.instance.ref('Tracking/$userID/$dayName');
      DatabaseEvent event = await trackingRef.once();
      DataSnapshot snapshot = event.snapshot;

      print('data is $snapshot');
      if (snapshot.value != null) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(snapshot.value as Map);
        setState(() {
          steps = data['steps'] ?? 0;
          caloriesBurned = data['caloriesBurned'] ?? 0.0;
          timeTracked = data['timeTracked'] ?? 0;
        });

        String timeTrackedFormatted = convertSecondsToMinutes(
            timeTracked); // Convert to minutes and seconds

        print("Steps: $steps");
        print("Calories Burned: $caloriesBurned");
        print("Time Tracked: $timeTrackedFormatted");
      } else {
        // If no data exists for the day, set default values
        setState(() {
          steps = 0;
          caloriesBurned = 0.0;
          timeTracked = 0;
        });
      }
    } catch (e) {
      print("Error fetching tracking data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  Future<void> _fetchWeeklyData() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    // Variables to store total values
    int totalSteps = 0;
    double totalMiles = 0.0;
    double totalKcal = 0.0;

    // Conversion factors
    const double stepsToMilesConversionFactor = 0.5; // Assuming 1000 steps = 0.5 miles
    const double stepsToKcalConversionFactor = 0.04; // Assuming 0.04 kcal per step

    Map<String, int> stepsData = {};

    try {
      // Fetch and calculate weekly data
      for (String dayName in daysOfWeek) {
        DatabaseReference trackingRef = FirebaseDatabase.instance.ref('Tracking/$userID/$dayName');
        DatabaseEvent event = await trackingRef.once();
        DataSnapshot snapshot = event.snapshot;

        int steps = 0;

        if (snapshot.value != null) {
          Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
          steps = data['steps'] ?? 0; // Extract the 'steps' for the day
        }

        // Store the steps data for each day
        stepsData[dayName] = steps;
        totalSteps += steps;

        // Calculate miles and kcal
        totalMiles += steps * stepsToMilesConversionFactor / 1000; // Convert steps to miles
        totalKcal += steps * stepsToKcalConversionFactor; // Convert steps to kcal
      }

      // Set the calculated weekly data
      setState(() {
        weeklySteps = stepsData;
        weeklyTotalSteps = totalSteps;
        weeklyTotalMiles = totalMiles; // Set the total miles for the week
        weeklyTotalKcal = totalKcal; // Set the total kcal for the week
      });

      // Print the results
      print('Weekly Steps: $weeklySteps');
      print('Total Steps for the Week: $weeklyTotalSteps');
      print('Total Miles for the Week: $weeklyTotalMiles');
      print('Total Kcal for the Week: $weeklyTotalKcal');
    } catch (e) {
      print("Error fetching weekly data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  double convertStepsToMiles(int steps) {
    const double stepsPerMile = 2000.0; // Assuming 12 steps equal 1 mile
    double miles = steps / stepsPerMile;
    return double.parse(miles.toStringAsFixed(2)); // Round to 2 decimal places
  }

  String convertSecondsToMinutes(int seconds) {
    int minutes = seconds ~/ 60; // Integer division for minutes
    int remainingSeconds = seconds % 60; // Remainder for seconds
    return "$minutes M $remainingSeconds S";
  }


  Future<void> _checkAndUpdateAllTimeTracking() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    DateTime currentTime = DateTime.now();

    // Check if it's Sunday at 11:59 PM
    if (currentTime.weekday == DateTime.sunday && currentTime.hour == 23 && currentTime.minute == 59) {
      // Variables to store weekly data
      int totalSteps = 0;
      double totalMiles = 0.0;
      double totalKcal = 0.0;
      Map<String, int> weeklyStepsData = {};

      List<String> daysOfWeek = [
        'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
      ];

      // Conversion factors
      const double stepsToMilesConversionFactor = 0.5; // Assuming 1000 steps = 0.5 miles
      const double stepsToKcalConversionFactor = 0.04; // Assuming 0.04 kcal per step

      try {
        // Fetch the data for the entire week and calculate totals
        for (String dayName in daysOfWeek) {
          DatabaseReference trackingRef = FirebaseDatabase.instance.ref('Tracking/$userID/$dayName');
          DatabaseEvent event = await trackingRef.once();
          DataSnapshot snapshot = event.snapshot;

          int steps = 0;

          if (snapshot.value != null) {
            Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
            steps = data['steps'] ?? 0;
          }

          // Store the daily steps data
          weeklyStepsData[dayName] = steps;
          totalSteps += steps;

          // Convert to miles and kcal
          totalMiles += steps * stepsToMilesConversionFactor / 1000; // Convert steps to miles
          totalKcal += steps * stepsToKcalConversionFactor; // Convert steps to kcal
        }

        // Prepare the all-time data node
        DatabaseReference allTimeTrackingRef = FirebaseDatabase.instance.ref('AllTimeTracking/$userID');
        DatabaseEvent allTimeEvent = await allTimeTrackingRef.once();
        DataSnapshot allTimeSnapshot = allTimeEvent.snapshot;

        Map<String, dynamic> allTimeData = {};
        if (allTimeSnapshot.value != null) {
          // If all-time data exists, retrieve it and update
          allTimeData = Map<String, dynamic>.from(allTimeSnapshot.value as Map);
          allTimeData['totalSteps'] += totalSteps;
          allTimeData['totalMiles'] += totalMiles;
          allTimeData['totalKcal'] += totalKcal;
        } else {
          // If no all-time data exists, create new
          allTimeData = {
            'totalSteps': totalSteps,
            'totalMiles': totalMiles,
            'totalKcal': totalKcal,
            'time': currentTime.toIso8601String(), // Storing current timestamp
          };
        }

        // Update the "AllTimeTracking" node with the new data
        await allTimeTrackingRef.set(allTimeData);

        // Clear the current week's data from the "Tracking" node
        for (String dayName in daysOfWeek) {
          DatabaseReference dailyRef = FirebaseDatabase.instance.ref('Tracking/$userID/$dayName');
          await dailyRef.remove(); // Remove data for each day of the week
        }

        // Log the updated all-time data
        print('Updated All-Time Data: $allTimeData');

        // Start the new week tracking (reset tracking data for Monday onwards)
        for (String dayName in daysOfWeek.sublist(0, 6)) {
          DatabaseReference trackingRef = FirebaseDatabase.instance.ref('Tracking/$userID/$dayName');
          await trackingRef.remove(); // Clear previous week tracking data
        }

        // Set the new weekly data for Monday (start fresh week tracking)
        setState(() {
          weeklySteps = weeklyStepsData;
          weeklyTotalSteps = totalSteps;
          weeklyTotalMiles = totalMiles;
          weeklyTotalKcal = totalKcal;
        });

        // Print the current week's data
        print('Current Week Data:');
        print('Total Steps: $weeklyTotalSteps');
        print('Total Miles: $weeklyTotalMiles');
        print('Total Kcal: $weeklyTotalKcal');
      } catch (e) {
        print("Error updating all-time tracking: $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // If the time is not Sunday 11:59 PM, show previous week's data
      print("Not Sunday 11:59 PM yet. Showing previous week data:");
      print('Weekly Steps: $weeklySteps');
      print('Total Steps for the Week: $weeklyTotalSteps');
      print('Total Miles for the Week: $weeklyTotalMiles');
      print('Total Kcal for the Week: $weeklyTotalKcal');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
                  painter: OpenCirclePainter1(steps: steps, maxSteps: 20000),
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
                            label: caloriesBurned.toStringAsFixed(2),
                            // Limit to 2 decimal places
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
                            label: convertSecondsToMinutes(timeTracked),
                            // Show elapsed time
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
                            label: '$steps', // Show steps count
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
                            label: '${convertStepsToMiles(steps)}',
                            // Show miles
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
                            'Monday',
                            'Tuesday',
                            'Wednesday',
                            'Thursday',
                            'Friday',
                            'Saturday',
                            'Sunday'
                          ];

                          // Sample daily step data
                          final dailySteps = weeklySteps[dayLabels[index]] ??
                              0; // Fetch steps for each day

                          double progress = dailySteps / 20000;
                          // Calculate progress based on the 20,000-step goal

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
                                  fontSize: 6,
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
                              width: 24,
// Define the width of the image
                              height: 24,
                            ),
                            SimpleTextWidget(
                              text: '$weeklyTotalSteps',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: dark ? AppColor.white : AppColor.black,
                              fontFamily: 'Poppins',
                              align: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.spaceBtwItems - 10,
                        ),
                        SimpleTextWidget(
                          text: 'Total steps ',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: dark ? AppColor.white : AppColor.black,
                          fontFamily: 'Poppins',
                          align: TextAlign.start,
                        ),
                        SizedBox(
                          height: AppSizes.spaceBtwInputFields,
                        ),
                        Container(
                          width: MyAppHelperFunctions.screenWidth(),
                          height: 1,
                          color: Colors.grey,
                        ),
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
                                label: '$weeklyTotalKcal',
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
                                label: '$timeTracked', // Show elapsed time
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
                                label: '$weeklyTotalSteps', // Show steps count
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
                                label: '$weeklyTotalMiles', // Show miles
                                value: 'miles',
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),

              // SizedBox(height: 20,),
              // BarChartWidget(
              //   values: [weeklyTotalMiles, weeklyTotalSteps, weeklyTotalKcal, 2333],
              //   labels: ["Kcal", "Time", "Step", "Miles"],
              // ),
              // SizedBox(height: 20,),


            ],
          ),
        ),
      ),
    );
  }
}
