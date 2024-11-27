import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/screens/home/chats/chat_user_screen/ChatsUserScreen.dart';
import 'package:fitness/screens/home/controller/DashboardController.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/ChallengedWidget.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/ExerciseWidget.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/FollowUserCard.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/ProgressContainer.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/TextWidget.dart';
import 'package:fitness/screens/home/footsteps/StepController.dart';
import 'package:fitness/screens/home/tracking_screen/TrackingScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../common/widgets/CircularImage.dart';
import '../../../common/widgets/MyAppGridLayout.dart';
import '../../../utils/constants/AppColor.dart';
import '../../../utils/constants/AppImagePaths.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';
import '../../../utils/helpers/MyAppHelper.dart';
import '../../exercise_screen/abs_screen/AbsScreen.dart';
import '../social/post_screen/AddPostScreen.dart';

List<Map<String, String>> maleExercise = [
  {
    'imagePath': AppImagePaths.maleAbsWorkout,
    'exerciseName': 'Abs Workout',
    'exerciseRepetition': '06 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleChestWorkout,
    'exerciseName': 'Chest Workout',
    'exerciseRepetition': '08 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleArmWorkout,
    'exerciseName': 'Arm Workout',
    'exerciseRepetition': '05 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleLegWorkout,
    'exerciseName': 'leg Workout',
    'exerciseRepetition': '06 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleShoulderWorkout,
    'exerciseName': 'Shoulder Workout',
    'exerciseRepetition': '04 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleBackWorkout,
    'exerciseName': 'Back Workout',
    'exerciseRepetition': '05',
  },
];
List<Map<String, String>> femaleExercises = [
  {
    'imagePath': AppImagePaths.femaleAbsWorkout,
    'exerciseName': 'Abs Workout',
    'exerciseRepetition': '06 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleChestWorkout,
    'exerciseName': 'Chest Workout',
    'exerciseRepetition': '08 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleArmWorkout,
    'exerciseName': 'Arm Workout',
    'exerciseRepetition': '05 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleLegWorkout,
    'exerciseName': 'leg Workout',
    'exerciseRepetition': '06 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleShoulderWorkout,
    'exerciseName': 'Shoulder Workout',
    'exerciseRepetition': '04 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleBackWorkout,
    'exerciseName': 'Back Workout',
    'exerciseRepetition': '05',
  },
];

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  DashboardController dashboardController = Get.put(DashboardController());

  StepController stepController = Get.put(StepController());
  String? name = '';
  String? imageUrl = '';
  List<Map<String, dynamic>> usersList = [];
  List<Map<String, dynamic>> filteredUsersList = [];
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> followingUsersList = [];
  bool isLoadingFollowing = true;

  bool isLoading = true;

  int stepCount = 0; // Today's steps
  List<int> weeklySteps =
      List<int>.filled(7, 0); // Steps for each day of the week
  int? baselineStepCount; // Baseline step count for the day
  int currentDayIndex = DateTime.now().weekday - 1; // 0 = Monday, 6 = Sunday
  double distance = 0.0; // Distance covered in meters
  Duration elapsedTime = Duration.zero; // Duration of the walking session
  Timer? _timer; // Timer for tracking elapsed time
  bool isTracking = false;
  static const int dailyStepTarget = 20000; // Target steps per day

  Stream<StepCount>? _stepCountStream;
  StreamSubscription<StepCount>? _stepCountSubscription;
  List<double> weeklyCalories = List<double>.filled(7, 0.0);

  @override
  void initState() {
    super.initState();
    dashboardController.fetchUserData(); // Fetch user data from the controller
    WidgetsBinding.instance.addObserver(this);
    requestPermissions();
    fetchFollowedUsers(); // Fetch the followed users
    fetchUsers(); // Fetch users when the widget is initialized
  }

  Future<void> requestPermissions() async {
    if (await Permission.activityRecognition.request().isGranted) {
      print("Activity recognition permission granted");
      initializePedometer();
    } else {
      print("Activity recognition permission not granted");
    }
  }

  void startListening() async {
    print('tracking value is$isTracking');

    if (await Permission.activityRecognition.isGranted) {
      print("Start Tracking.");

      initializePedometer();
      startTimer();
    } else {
      print("Activity recognition permission is not granted.");
    }
  }

  void stopListening() async {
    if (kDebugMode) {
      print('tracking value is$isTracking');
    }
    // Assuming you already have variables for step count, calories burned, and time tracked
    String userID = FirebaseAuth.instance.currentUser!.uid;
    double caloriesBurned = calculateCaloriesBurned(
        stepCount); // Calculate the total calories burned
    int timeTracked =
        calculateTimeTracked(); // Calculate the time spent in the tracking session

    // Get the current date and format it for the day name (e.g., "Monday")
    String dayName = getCurrentDayName();

    // Firebase reference to track steps for the user on the current day
    DatabaseReference trackingRef =
        FirebaseDatabase.instance.ref('Tracking/$userID/$dayName');

    // Fetch the existing step count data for the current day
    DatabaseEvent event = await trackingRef
        .once(); // This returns a DatabaseEvent, not DataSnapshot
    DataSnapshot snapshot =
        event.snapshot; // Extract the snapshot from the DatabaseEvent

    // Safely cast the snapshot value to Map<String, dynamic>
    Map<String, dynamic> existingData = (snapshot.value is Map)
        ? Map<String, dynamic>.from(snapshot.value as Map)
        : {};

    // Get the previous step count, calories, and time if they exist
    int previousSteps = existingData['steps'] ?? 0;
    double previousCalories = existingData['caloriesBurned'] ?? 0.0;
    int previousTimeTracked = existingData['timeTracked'] ?? 0;

    // Add the new step count, calories, and time to the previous values
    int newStepCount = previousSteps + stepCount;
    double newCaloriesBurned =
        previousCalories + caloriesBurned; // Add the newly calculated calories
    int newTimeTracked =
        previousTimeTracked + timeTracked; // Add the new time tracked

    // Prepare the updated data to be saved
    Map<String, dynamic> data = {
      'steps': newStepCount,
      'caloriesBurned': newCaloriesBurned, // Updated total calories burned
      'timeTracked': newTimeTracked, // Updated total time tracked
    };

    // Update the database with the new data
    trackingRef.set(data).then((_) {
      print("Footstep tracking data updated for $dayName.");
    }).catchError((error) {
      print("Failed to update data: $error");
    });

    // Stop the subscription and clean up
    _stepCountSubscription?.cancel();
    _stepCountSubscription = null;
    _stepCountStream = null;
    stopTimer();

    print("Stopped tracking footsteps and cleared pedometer stream.");
  }

  double calculateCaloriesBurned(int steps) {
    // Use your formula to calculate calories burned based on the steps
    double caloriesPerStep = 0.04; // Example, adjust based on your calculations
    return steps * caloriesPerStep;
  }

// Function to calculate the time tracked (example)
  int calculateTimeTracked() {
    // Return the total time in minutes or seconds
    return 60; // Example, replace with actual logic
  }

// Function to get the current day name (example)
  String getCurrentDayName() {
    DateTime now = DateTime.now();
    return now.weekday == DateTime.monday
        ? 'Monday'
        : now.weekday == DateTime.tuesday
            ? 'Tuesday'
            : now.weekday == DateTime.wednesday
                ? 'Wednesday'
                : now.weekday == DateTime.thursday
                    ? 'Thursday'
                    : now.weekday == DateTime.friday
                        ? 'Friday'
                        : now.weekday == DateTime.saturday
                            ? 'Saturday'
                            : 'Sunday';
  }

  Future<void> initializePedometer() async {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountSubscription = _stepCountStream!.listen(
      (event) {
        print("Steps detected: ${event.steps}");
        onStepCount(event);
      },
      onError: (error) => print("Step count error: $error"),
    );
  }

  void onStepCount(StepCount event) {
    int todayIndex = DateTime.now().weekday - 1;
    baselineStepCount ??= event.steps;

    if (todayIndex != currentDayIndex) {
      currentDayIndex = todayIndex;
      baselineStepCount = event.steps;
      setState(() {
        weeklySteps[currentDayIndex] = 0;
        stepCount = 0;
        distance = 0.0;
        elapsedTime = Duration.zero;
      });
    }

    if (baselineStepCount != null) {
      int calculatedSteps = event.steps - baselineStepCount!;
      if (calculatedSteps != weeklySteps[currentDayIndex]) {
        setState(() {
          weeklySteps[currentDayIndex] = calculatedSteps;
          stepCount = calculatedSteps;
          distance = calculatedSteps * 0.762; // Average stride length in meters
        });
      }
    }

    double caloriesBurned = calculateCalories(stepCount);
    print('Calories burned: $caloriesBurned');
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        elapsedTime += Duration(seconds: 1); // Update elapsed time
      });
    });
    setState(() {
      isTracking = true; // Indicate that the tracking is started
    });
  }

  void stopTimer() {
    _timer?.cancel();
    setState(() {
      isTracking = false;
    });
  }

  void onResumeTracking() {
    setState(() {
      isTracking = true;
    });
    startListening(); // Resume step tracking
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _stepCountSubscription?.isPaused == true) {
      _stepCountSubscription?.resume();
    } else if (state == AppLifecycleState.paused) {
      _stepCountSubscription?.pause();
    }

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stepCountSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  double calculateCalories(int steps) {
    const double caloriesPerStep = 0.04; // Estimated calories per step
    double calories = steps * caloriesPerStep;

    // Round to 4 decimal places
    return double.parse(calories.toStringAsFixed(4));
  }

  String formatElapsedTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return "$hours:${twoDigits(minutes)}:${twoDigits(seconds)}";
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          SystemNavigator.pop(); // Closes the app on Android
        } else if (Platform.isIOS) {
          exit(0); // Closes the app on iOS
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              CircularImage(
                  imageUrl: dashboardController.imageUrl ??
                      AppImagePaths.placeholder1,
                  size: 50),
              // CircularImage(imageUrl: dashboardController.imageUrl!, size: 50,) ,
              SizedBox(
                width: 6,
              ),
              SimpleTextWidget(
                  text: dashboardController.name!,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: dark ? Colors.white : AppColor.black,
                  fontFamily: 'Poppins')
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => const ChatsUserScreen());
                if (kDebugMode) {
                  print('message');
                }
              },
              child: Image(
                width: 20,
                height: 20,
                color: dark ? AppColor.white : AppColor.black,
                image: const AssetImage(AppImagePaths.messages),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {},
              child: Image(
                width: 20,
                height: 20,
                color: dark ? AppColor.white : AppColor.black,
                image: const AssetImage(AppImagePaths.notification),
              ),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MyAppHelperFunctions.screenWidth() * 0.95,
                  height: 170, // Adjust height as needed
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
                          text: 'Your  progress',
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: dark ? AppColor.white : AppColor.black,
                          fontFamily: 'Poppins',
                          align: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProgressContainer(
                              iconPath: AppImagePaths.kcalicon,
                              label: '${calculateCalories(stepCount)}',
                              // Show calories
                              value: 'Kcal',
                            ),
                            ProgressContainer(
                              iconPath: AppImagePaths.clock,
                              label: formatElapsedTime(elapsedTime),
                              // Show elapsed time
                              value: 'Time',
                            ),
                            ProgressContainer(
                              iconPath: AppImagePaths.location,
                              label: '$stepCount', // Show steps count
                              value: 'Steps',
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Rounded Progress Line with Orange Color
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // Rounded corners
                          child: LinearProgressIndicator(
                            value: 0.76,
                            // Example: Set to your dynamic progress value (e.g., 0.76 = 76%)
                            minHeight: 10,
                            // Increase thickness for better visibility
                            backgroundColor: dark
                                ? AppColor.grey.withOpacity(0.1)
                                : AppColor.grey.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.orangeColor), // Set to orange color
                          ),
                        ),
                        const SizedBox(height: 2),

                        // Percentage Text Below Progress Bar
                        Text(
                          '76%',
                          // Show dynamic progress percentage (you can replace this with the actual percentage)
                          style: TextStyle(
                            color: dark ? AppColor.white : AppColor.black,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              if (kDebugMode) {
                                print('click');
                              }

                              Get.to(TrackingScreen(
                                dayName: getCurrentDayName(),
                              ));
                            },
                            child: SimpleTextWidget(
                                align: TextAlign.end,
                                text: 'See More',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: dark ? AppColor.white : AppColor.black,
                                fontFamily: 'Poppins'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.inputFieldRadius),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (!isTracking) {
                            MyAppHelperFunctions.showSnackBar('Tracking has been started');
                            startListening(); // Call the function explicitly
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: Size(double.infinity,
                              30), // Set minimum size to match height
                        ),
                        child: SimpleTextWidget(
                          text: 'Record a Run',
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: dark ? AppColor.black : AppColor.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (isTracking) {
                            MyAppHelperFunctions.showSnackBar('Tracking has been Stopped');

                            stopListening(); // Call the function explicitly
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.error,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: Size(double.infinity,
                              30), // Set minimum size to match height
                        ),
                        child: SimpleTextWidget(
                          text: 'Stop Run',
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: dark ? AppColor.black : AppColor.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                )

                ,
                SizedBox(height: AppSizes.inputFieldRadius),
                ChallengedWidget(dark: dark),
                const SizedBox(height: AppSizes.inputFieldRadius - 5),
                Text(
                  AppStrings.fitnessTitans,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: dark ? AppColor.white : AppColor.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: AppSizes.inputFieldRadius),
                MyAppGridLayout(
                  itemCount: filteredUsersList.length,
                  // Set the itemCount to the length of the filtered list
                  itemBuilder: (context, index) {
                    final user = filteredUsersList[index];
                    // Get the user from the filtered list
                    return Card(
                      child: FollowUserCard(
                        dark: dark,
                        userName: user['name'] ?? 'Unknown User',
                        // Pass the user's name
                        imagePath: user['imageUrl'] ?? '',
                        // Pass the user's image URL
                        onRemovePressed: () => onRemove(user['id']),
                        onFollowPressed: () => onFollow(
                            user['id'], user['name'], user['imageUrl']),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),

                const SizedBox(height: AppSizes.spaceBtwInputFields),
                TextWidget(dark: dark),

                // Use FutureBuilder to handle the async gender fetching
                FutureBuilder<String>(
                  future: dashboardController.fetchUserGender(),
                  // Call the gender fetching function
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading while waiting for the future to complete
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Handle errors
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      // Once the data (gender) is received, update the exercise list based on gender
                      String gender = snapshot.data!;
                      List<Map<String, String>> exercisesList =
                          gender == 'Female' ? femaleExercises : maleExercise;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: exercisesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.zero,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => AbsScreen(
                                      exerciseType: exercisesList[index]
                                          ['exerciseName']!,
                                      exerciseRepititon: exercisesList[index]
                                          ['exerciseRepetition']!,
                                      gender: gender,
                                    ));
                              },
                              child: ExerciseWidget(
                                dark: dark,
                                imagePath: exercisesList[index]['imagePath']!,
                                exerciseName: exercisesList[index]
                                    ['exerciseName']!,
                                exerciseRepeation: exercisesList[index]
                                    ['exerciseRepetition']!,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      // If no data is available
                      return const Text('No gender data available.');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddPostScreen());
          },
          backgroundColor: AppColor.orangeColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(50), // Ensures the shape is a circle
          ),
          child: const Icon(Icons.add,
              color: Colors.white, size: 45), // Customize the FAB icon
        ),
      ),
    );
  }

  Future<void> fetchFollowedUsers() async {
    final User? currentUser =
        FirebaseAuth.instance.currentUser; // Get current logged-in user
    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
      return;
    }

    final DatabaseReference followingRef = FirebaseDatabase.instance.ref(
        'users/${currentUser.uid}/following'); // Reference to current user's 'following' node

    setState(() {
      isLoadingFollowing = true; // Set loading state to true before fetching
    });

    // Listen for value changes at the 'following' node
    followingRef.onValue.listen((DatabaseEvent event) {
      final dataSnapshot = event.snapshot;

      // Check if data is available
      if (dataSnapshot.exists) {
        // Convert the data to a Map
        final Map<dynamic, dynamic> followingMap =
            dataSnapshot.value as Map<dynamic, dynamic>;

        // Clear previous data
        followingUsersList.clear();

        // Iterate through each followed user in the map
        followingMap.forEach((key, value) {
          // key is the followed user ID
          // value contains the followed user data (e.g., name, imageUrl)
          final followedUserId = key;
          final followedUserName = value['name'];
          final followedUserImageUrl =
              value['imageUrl'] ?? AppImagePaths.placeholder1;

          // Add followed user data to the list
          followingUsersList.add({
            'id': followedUserId,
            'name': followedUserName,
            'imageUrl': followedUserImageUrl,
          });
        });

        if (kDebugMode) {
          print(' followed users found. $followingUsersList');
        }

        setState(() {
          isLoadingFollowing =
              false; // Set loading state to false after fetching
        });
      } else {
        if (kDebugMode) {
          print('No followed users found.');
        }
        setState(() {
          isLoadingFollowing = false; // Set loading state to false
        });
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('Error fetching followed users: $error');
      }
      setState(() {
        isLoadingFollowing = false; // Set loading state to false
      });
    });
  }

  Future<void> fetchUsers() async {
    final DatabaseReference usersRef =
        FirebaseDatabase.instance.ref('users'); // Reference to the 'users' node
    final User? currentUser =
        FirebaseAuth.instance.currentUser; // Get the current logged-in user

    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
      return;
    }

    // Listen for value changes at the 'users' node
    usersRef.onValue.listen((DatabaseEvent event) {
      final dataSnapshot = event.snapshot;

      // Check if data is available
      if (dataSnapshot.exists) {
        // Convert the data to a Map
        final Map<dynamic, dynamic> usersMap =
            dataSnapshot.value as Map<dynamic, dynamic>;

        // Clear previous data
        usersList.clear();

        // Iterate through each user in the map
        usersMap.forEach((key, value) {
          final userId = key;
          final userName =
              value['name']; // Adjust according to your data structure
          final userImageUrl = value['imageUrl'] ??
              AppImagePaths.placeholder1; // Get image URL or use placeholder

          // Add user data to the list only if it's not the current user and not followed
          if (userId != currentUser.uid && !_isUserFollowed(userId)) {
            usersList.add({
              'id': userId,
              'name': userName,
              'imageUrl': userImageUrl, // Include image URL
            });
          }
        });

        // Initialize filtered list with all users (filtered for those not followed)
        filteredUsersList = List.from(usersList);
        setState(() {}); // Update the UI after fetching users
      } else {
        if (kDebugMode) {
          print('No users found.');
        }
      }

      setState(() {
        isLoading = false; // Set loading state to false after fetching
      });
    }, onError: (error) {
      if (kDebugMode) {
        print('Error fetching users: $error');
      }
      setState(() {
        isLoading = false; // Set loading state to false after fetching
      });
    });
  }

  bool _isUserFollowed(String userId) {
    return followingUsersList.any((user) => user['id'] == userId);
  }

  void onRemove(String userId) {
    setState(() {
      usersList.removeWhere((user) => user['id'] == userId);
      filteredUsersList.removeWhere((user) => user['id'] == userId);
    });
  }

  void onFollow(
      String followedUserId, String followedUserName, String imageUrl) async {
    final User? currentUser =
        FirebaseAuth.instance.currentUser; // Get current logged-in user
    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
      return;
    }

    final DatabaseReference currentUserRef = FirebaseDatabase.instance
        .ref('users/${currentUser.uid}/following/$followedUserId');
    final DatabaseReference followedUserRef = FirebaseDatabase.instance
        .ref('users/$followedUserId/followers/${currentUser.uid}');

    try {
      // Update the current user's "following" node with the followed user's info
      await currentUserRef.set({
        'id': followedUserId,
        'name': followedUserName,
        'imageUrl': imageUrl,
      });

      // Update the followed user's "followers" node with the current user's info
      await followedUserRef.set({
        'id': currentUser.uid,
        'name': currentUser.displayName ?? 'Unknown',
        'imageUrl': imageUrl,
// Use displayName if available
      });

      if (kDebugMode) {
        print(
            "Followed user $followedUserName and updated their followers list.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error following user: $e");
      }
    }
  }
}
