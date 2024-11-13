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

class _DashboardState extends State<Dashboard>  with WidgetsBindingObserver {

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
  List<int> weeklySteps = List<int>.filled(7, 0); // Steps for each day of the week
  int? baselineStepCount; // Baseline step count for the day
  int currentDayIndex = DateTime.now().weekday - 1; // 0 = Monday, 6 = Sunday

  late Stream<StepCount> _stepCountStream;
  StreamSubscription<StepCount>? _stepCountSubscription;







  @override
  void initState() {
    super.initState();
    dashboardController.fetchUserData(); // Fetch user data from the controller

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
    if (await Permission.activityRecognition.isGranted) {
      initializePedometer();
    } else {
      print("Activity recognition permission is not granted.");
    }
  }

  Future<void> initializePedometer() async {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountSubscription = _stepCountStream.listen(
          (event) {
        print("Steps detected: ${event.steps}");
        onStepCount(event);
      },
      onError: (error) => print("Step count error: $error"),
    );
  }
  void onStepCount(StepCount event) {
    int todayIndex = DateTime.now().weekday - 1; // Get today's index (0 = Monday)
    print("Steps detected: ${event.steps}");
    print("Current Day Index: $todayIndex");

    // Initialize baseline if it's null (first time the app runs for the day)
    if (baselineStepCount == null) {
      baselineStepCount = event.steps;
      print("Initial baseline set to $baselineStepCount for the day.");
    }

    // Check if the day has changed
    if (todayIndex != currentDayIndex) {
      print("Day has changed. Setting new baseline.");
      currentDayIndex = todayIndex;
      baselineStepCount = event.steps; // Reset baseline for the new day
      setState(() {
        weeklySteps[currentDayIndex] = 0; // Reset today's steps in weekly array
        stepCount = 0; // Reset today's step count in UI
      });
    }

    // Update today's steps based on the new step count and baseline
    if (baselineStepCount != null) {
      int calculatedSteps = event.steps - baselineStepCount!;
      if (calculatedSteps != weeklySteps[currentDayIndex]) {
        setState(() {
          weeklySteps[currentDayIndex] = calculatedSteps;
          stepCount = calculatedSteps;
        });
        print("Updated weeklySteps for today (${_getDayName(todayIndex)}): ${weeklySteps[currentDayIndex]}");
      }
    } else {
      print("Error: Baseline step count is null.");
    }
  }

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



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _stepCountSubscription?.isPaused == true) {
      _stepCountSubscription?.resume();
    } else if (state == AppLifecycleState.paused) {
      _stepCountSubscription?.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stepCountSubscription?.cancel();
    super.dispose();
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
      child:
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(children: [
            CircularImage(imageUrl: dashboardController.imageUrl ?? AppImagePaths.placeholder1, size: 50)
,
            // CircularImage(imageUrl: dashboardController.imageUrl!, size: 50,) ,
            SizedBox(width: 6,),
            SimpleTextWidget(text: dashboardController.name!, fontWeight: FontWeight.w500, fontSize: 14, color: dark ? Colors.white : AppColor.black
                , fontFamily: 'Poppins')
          ],),
          actions: [
            GestureDetector(
              onTap: (){

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
              onTap: () {
              },
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
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: MyAppHelperFunctions.screenWidth() * 0.95,
                //   height: 150,
                //   decoration: BoxDecoration(
                //     color: dark ? AppColor.grey.withOpacity(0.1) : AppColor.grey.withOpacity(0.3),
                //     borderRadius: const BorderRadius.all(Radius.circular(6)),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         SimpleTextWidget(
                //           text: 'Your weekly progress',
                //           fontWeight: FontWeight.w300,
                //           fontSize: 13,
                //           color: dark ? AppColor.white : AppColor.black,
                //           fontFamily: 'Poppins',
                //           align: TextAlign.start,
                //         ),
                //         const SizedBox(height: 8),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             ProgressContainer(
                //               iconPath: AppImagePaths.kcalicon,
                //               label: '${stepController.caloriesBurned.toStringAsFixed(2)} ', // Show calories
                //               value: 'Kcal',
                //             ),
                //             ProgressContainer(
                //               iconPath: AppImagePaths.clock,
                //               label: '234', // Show elapsed time
                //               value: 'Time',
                //             ),
                //             ProgressContainer(
                //               iconPath: AppImagePaths.location,
                //               label: '${stepCount}', // Show steps count
                //               value: 'Steps',
                //             ),
                //           ],
                //         ),
                //
                //
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                  width: MyAppHelperFunctions.screenWidth() * 0.95,
                  height: 200, // Adjust height as needed
                  decoration: BoxDecoration(
                    color: dark ? AppColor.grey.withOpacity(0.1) : AppColor.grey.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SimpleTextWidget(
                          text: 'Your weekly progress',
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
                              label: stepController.caloriesBurned.toStringAsFixed(2), // Show calories
                              value: 'Kcal',
                            ),
                            ProgressContainer(
                              iconPath: AppImagePaths.clock,
                              label: '234', // Show elapsed time
                              value: 'Time',
                            ),
                            ProgressContainer(
                              iconPath: AppImagePaths.location,
                              label: '$stepCount', // Show steps count
                              value: 'Steps',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Rounded Progress Line with Orange Color
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                          child: LinearProgressIndicator(
                            value: 0.76, // Example: Set to your dynamic progress value (e.g., 0.76 = 76%)
                            minHeight: 10, // Increase thickness for better visibility
                            backgroundColor: dark ? AppColor.grey.withOpacity(0.1) : AppColor.grey.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(AppColor.orangeColor), // Set to orange color
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Percentage Text Below Progress Bar
                        Text(
                          '76%', // Show dynamic progress percentage (you can replace this with the actual percentage)
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
                            onTap: (){
                              print('click');

                              Get.to(TrackingScreen());

                            },
                            child: SimpleTextWidget(
                                align: TextAlign.end,
                                text: 'See More', fontWeight: FontWeight.w300, fontSize: 12, color: dark ? AppColor.white : AppColor.black, fontFamily: 'Poppins'),
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
                      child: GestureDetector(
                        onTap: () => startListening(),
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColor.orangeColor,
                            borderRadius: BorderRadius.circular(16),
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
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => stepController.stopListening(),
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColor.error,
                            borderRadius: BorderRadius.circular(16),
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
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => stepController.clearData(),
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColor.blueColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SimpleTextWidget(
                            text: 'Clear Data',
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: dark ? AppColor.black : AppColor.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.inputFieldRadius),
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
                  itemCount: filteredUsersList.length, // Set the itemCount to the length of the filtered list
                  itemBuilder: (context, index) {
                    final user = filteredUsersList[index];
                    // Get the user from the filtered list
                    return Card(
                      child: FollowUserCard(
                        dark: dark,
                        userName: user['name'] ?? 'Unknown User', // Pass the user's name
                        imagePath: user['imageUrl'] ?? '', // Pass the user's image URL
                        onRemovePressed: () => onRemove(user['id']),
                        onFollowPressed: () => onFollow(
                            user['id'],
                            user['name'],
                            user[
                            'imageUrl']),
                      ),
                    );

                  },
                  scrollDirection: Axis.horizontal,
                ),

                             const SizedBox(height: AppSizes.spaceBtwInputFields),
                TextWidget(dark: dark),

                // Use FutureBuilder to handle the async gender fetching
                FutureBuilder<String>(
                  future: dashboardController.fetchUserGender(), // Call the gender fetching function
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
                      List<Map<String, String>> exercisesList = gender == 'Female'
                          ? femaleExercises
                          : maleExercise;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: exercisesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.zero,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(()=>AbsScreen(
                                  exerciseType:
                                  exercisesList[index]['exerciseName']!,
                                  exerciseRepititon:
                                  exercisesList[index]['exerciseRepetition']!,
                                  gender: gender,
                                ));
                              },
                              child: ExerciseWidget(
                                dark: dark,
                                imagePath: exercisesList[index]['imagePath']!,
                                exerciseName:
                                exercisesList[index]['exerciseName']!,
                                exerciseRepeation:
                                exercisesList[index]['exerciseRepetition']!,
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
            borderRadius: BorderRadius.circular(50), // Ensures the shape is a circle
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 45), // Customize the FAB icon
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
          final followedUserImageUrl = value['imageUrl'] ?? AppImagePaths.placeholder1;

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
    final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users'); // Reference to the 'users' node
    final User? currentUser = FirebaseAuth.instance.currentUser; // Get the current logged-in user

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
        final Map<dynamic, dynamic> usersMap = dataSnapshot.value as Map<dynamic, dynamic>;

        // Clear previous data
        usersList.clear();

        // Iterate through each user in the map
        usersMap.forEach((key, value) {

          final userId = key;
          final userName = value['name']; // Adjust according to your data structure
          final userImageUrl = value['imageUrl'] ?? AppImagePaths.placeholder1; // Get image URL or use placeholder

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

// Helper method to check if a user is already followed
  bool _isUserFollowed(String userId) {
    return followingUsersList.any((user) => user['id'] == userId);
  }

  void onRemove(String userId) {
    setState(() {
      usersList.removeWhere((user) => user['id'] == userId);
      filteredUsersList.removeWhere((user) => user['id'] == userId);
    });
  }

  void onFollow(String followedUserId, String followedUserName, String imageUrl) async {
    final User? currentUser = FirebaseAuth.instance.currentUser; // Get current logged-in user
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
