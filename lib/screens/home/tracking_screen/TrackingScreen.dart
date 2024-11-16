import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/screens/home/tracking_screen/widgets/CircularProgressPainter.dart';
import 'package:fitness/screens/home/tracking_screen/widgets/OpenCirclePainter1.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/AppImagePaths.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchWeeklyStepsData();
    _fetchTrackingData();
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

  // Updated _fetchWeeklyStepsData method to match the data structure
  Future<void> _fetchWeeklyStepsData() async {
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
    Map<String, int> stepsData = {};

    try {
      for (String dayName in daysOfWeek) {
        DatabaseReference trackingRef =
            FirebaseDatabase.instance.ref('Tracking/$userID/$dayName');
        DatabaseEvent event = await trackingRef.once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.value != null) {
          Map<String, dynamic> data =
              Map<String, dynamic>.from(snapshot.value as Map);

          // Extract the 'steps' for the day
          stepsData[dayName] =
              data['steps'] ?? 0; // Default to 0 if 'steps' is null
        } else {
          stepsData[dayName] = 0; // Set to 0 if no data exists for that day
        }
      }

      setState(() {
        weeklySteps = stepsData;
      });
      print('Weekly Steps: $weeklySteps');
    } catch (e) {
      print("Error fetching weekly steps data: $e");
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
                            label: '${caloriesBurned.toStringAsFixed(2)}',
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
                            label: '${convertSecondsToMinutes(timeTracked)}',
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
                  borderRadius:
                  const BorderRadius.all(Radius.circular(6)),
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
                            color:
                            dark ? AppColor.white : AppColor.black,
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
                              text: '34534534',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: dark
                                  ? AppColor.white
                                  : AppColor.black,
                              fontFamily: 'Poppins',
                              align: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.spaceBtwItems - 10,
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
                        Container(
                          width: MyAppHelperFunctions.screenWidth(),
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: AppSizes.spaceBtwInputFields,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
// Blur radius for the shadow
                                    spreadRadius: 2,
// Spread radius for the shadow
                                    offset: Offset(0,
                                        4), // Position of the shadow (X, Y)
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
// Blur radius for the shadow
                                    spreadRadius: 2,
// Spread radius for the shadow
                                    offset: Offset(0,
                                        4), // Position of the shadow (X, Y)
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
// Blur radius for the shadow
                                    spreadRadius: 2,
// Spread radius for the shadow
                                    offset: Offset(0,
                                        4), // Position of the shadow (X, Y)
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
// Blur radius for the shadow
                                    spreadRadius: 2,
// Spread radius for the shadow
                                    offset: Offset(0,
                                        4), // Position of the shadow (X, Y)
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



