import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitness/screens/exercise_screen/exercise_start_screen/widgets/CenteredTextWithIconsRow.dart';
import 'package:fitness/screens/exercise_screen/exercise_start_screen/widgets/CircleWithText.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import '../../exercise_screen_controller/ExerciseProgressController.dart';

class ExerciseProgressScreen extends StatefulWidget {
  const ExerciseProgressScreen({
    super.key,
    required this.exerciseType,
    required this.gender,
  });

  final String exerciseType;
  final String gender;

  @override
  _ExerciseProgressScreenState createState() => _ExerciseProgressScreenState();
}

class _ExerciseProgressScreenState extends State<ExerciseProgressScreen> {
  List<Map<String, String>> exerciseList = []; // Store the retrieved exercises
  bool isLoading = true; // Show loading while retrieving data
  final ExerciseProgressController controller =
      Get.put(ExerciseProgressController());
  String firstExerciseName = '';
  String firstExerciseDuration = '';
  String imageurl = '';
  String reps = '';
  String sets = '';
  int currentIndex = 0; // Current exercise index
  bool hasStarted = false; // Track if the exercise has started
  late Timer countdownTimer; // Declare the countdown Timer
  Duration remainingDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadExercises(); // Load exercises when the screen is initialized
  }

  Future<void> _loadExercises() async {
    List<Map<String, String>> storedExercises = await getStoredExercises();

    if (storedExercises.isNotEmpty) {
      setState(() {
        exerciseList = storedExercises;
        updateExerciseData(currentIndex); // Update to show first exercise
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false; // Ensure loading state is updated
      });
    }
  }

  Future<List<Map<String, String>>> getStoredExercises() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonExercises =
        prefs.getStringList('exercises_${widget.exerciseType}');

    if (jsonExercises != null) {
      return jsonExercises
          .map((json) => Map<String, String>.from(jsonDecode(json)))
          .toList();
    }
    return []; // Return an empty list if no data is found
  }

  void updateExerciseData(int index) {
    if (exerciseList.isNotEmpty && index >= 0 && index < exerciseList.length) {
      Map<String, String> exercise =
          exerciseList[index]; // Get the current exercise
      firstExerciseName = exercise["exerciseName"] ?? "N/A"; // Set exerciseName
      firstExerciseDuration = exercise["durations"] ?? "N/A"; // Set durations
      imageurl = exercise["musclePath"] ?? "N/A"; // Set durations

      print('image url is progreee su s $imageurl');
      // Breakdown exerciseRepetition
      String exerciseRepetition = exercise["exerciseRepetition"] ?? "N/A";
      List<String> repetitionParts =
          exerciseRepetition.split('x'); // Split by 'x'

      if (repetitionParts.length == 2) {
        reps = repetitionParts[0].trim(); // Get the Reps part
        sets = repetitionParts[1].trim(); // Get the Sets part
      } else {
        reps = "N/A"; // Handle invalid format
        sets = "N/A"; // Handle invalid format
      }

      setState(() {}); // Update the UI
    }
  }

  @override
  void dispose() {
    countdownTimer.cancel(); // Cancel the timer if the widget is disposed
    super.dispose();
  }
  void startCountdown() {
    if (firstExerciseDuration.isNotEmpty &&
        RegExp(r'^\d+$').hasMatch(firstExerciseDuration)) {
      remainingDuration = Duration(seconds: int.parse(firstExerciseDuration)); // Set remaining duration
      hasStarted = true; // Set hasStarted to true

      countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (remainingDuration.inSeconds > 0) {
            remainingDuration = remainingDuration - const Duration(seconds: 1);
          } else {
            timer.cancel(); // Stop the timer when it reaches zero
            hasStarted = false; // Reset hasStarted when the timer ends
            controller.toggleButton(); // Show the Start button again
          }
        });
      });
    } else {
      // Handle the case where the duration is invalid
      print('Invalid exercise duration: $firstExerciseDuration');
      // You may want to show an error message to the user or set a default duration
    }
  }




  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomAppBar(
          height: 85,
          padding: const EdgeInsets.only(bottom: 5),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Start Button
                if (controller.isStartButtonVisible.value) // Show Start button if visible
                  Expanded(
                    child: ButtonWidget(
                      dark: dark,
                      onPressed: () {
                        // Start the countdown
                        startCountdown();
                        controller.isStartButtonVisible.value = false; // Hide Start button
                      },
                      buttonText: 'Start',
                    ),
                  ),
                // Pause Button
                if (!controller.isStartButtonVisible.value) // Show Pause button if Start is hidden
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        hasStarted = false; // Reset hasStarted when paused
                        countdownTimer.cancel(); // Cancel the timer
                        controller.isStartButtonVisible.value = true; // Show Start button again
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.orangeColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.pause, color: Colors.white),
                            Text(
                              'Pause',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color: AppColor.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),

      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSizes.appBarHeight - 10),
              SimpleTextWidget(
                text: firstExerciseName,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              // Image container here...
              Container(
                width: AppDevicesUtils.getScreenWidth(context) * 0.95,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // Adjust this value to control the curvature
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.transparent, // Shadow color
                      spreadRadius: 1, // Spread radius
                      blurRadius: 2, // Blur radius
                      offset: Offset(0, 1), // Shadow offset
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Ensure the child is clipped to the same radius
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          imageurl,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image loaded successfully
                            }
                            // Show a loading spinner while the image is loading
                            return const Center(
                              child: SpinKitFadingCircle( // Optional: Loading spinner
                                color: Colors.blue, // Customize the spinner color
                                size: 50.0,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            // Show a placeholder or error widget if the image fails to load
                            return const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                                size: 50.0,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                          icon:  Icon(Icons.arrow_back ,color:  dark ? AppColor.white : AppColor.black,),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context); // Use Navigator to go back
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.appBarHeight),
              CircleWithText(
                text: hasStarted
                    ? remainingDuration.inSeconds
                        .toString() // Display remaining time if started
                    : reps,
                // Display reps if not started
                size: 144.0,
                borderColor: AppColor.orangeColor,
                backgroundColor: Colors.transparent,
                textColor: dark ? AppColor.blueColor : AppColor.black,
                borderWidth: 12.0,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems + 10),
              Container(
                alignment: Alignment.center,
                child: SimpleTextWidget(
                  text: sets,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems + 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CenteredTextWithIconsRow(
                    text: '${currentIndex + 1}',
                    // Show the current index + 1
                    leftIcon: AppImagePaths.right,
                    rightIcon: AppImagePaths.left,
                    text1: "",
                    textColor: dark ? AppColor.white : AppColor.black,
                    onLeftIconPressed: () {
                      // Navigate to the previous exercise
                      if (currentIndex > 0) {
                        currentIndex--; // Decrement index
                        updateExerciseData(
                            currentIndex); // Update data for new index
                      }
                    },
                    onRightIconPressed: () {
                      // Navigate to the next exercise
                      if (currentIndex < exerciseList.length - 1) {
                        currentIndex++; // Increment index
                        updateExerciseData(
                            currentIndex); // Update data for new index
                      }
                    },
                    leftIconAngle: 0,
                    rightIconAngle: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


