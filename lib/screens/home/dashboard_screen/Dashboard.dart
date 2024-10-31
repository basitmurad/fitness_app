import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/screens/home/chats/chat_user_screen/ChatsUserScreen.dart';
import 'package:fitness/screens/home/controller/DashboardController.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/ChallengedWidget.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/ExerciseWidget.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/FollowUserCard.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/ProgressContainer.dart';
import 'package:fitness/screens/home/dashboard_screen/widgets/TextWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
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
    'exerciseName': 'Legs Workout',
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
    'exerciseName': 'Legs Workout',
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

class _DashboardState extends State<Dashboard> {

  DashboardController dashboardController = Get.put(DashboardController());

  String? name = '';
  String? imageUrl = '';
  List<Map<String, dynamic>> usersList = [];
  List<Map<String, dynamic>> filteredUsersList = [];
  TextEditingController searchController = TextEditingController();
  final String placeholderImageUrl = 'https://ttwo.dk/person-placeholder/';
  List<Map<String, dynamic>> followingUsersList = [];
  bool isLoadingFollowing = true;

  bool isLoading = true;

  late Stream<StepCount> _stepCountStream; // Stream for step count
  int stepCount = 0; // Initialize step count
  bool isRunning = false; // Track running state

  // Variables for calculating values
  String totalTime = '0h 0m';
  String distanceCovered = '0 miles';
  String caloriesBurned = '0 Kcal';
  final int stepsPerMile = 2000; // Average steps in a mile
  final int kcalPerMile = 100; // Calories burned per mile
  int elapsedTime = 0; // Elapsed time for running

  // Initialize the pedometer and start listening
  void startRunning() {
    isRunning = true;
    elapsedTime = 0; // Reset elapsed time
    stepCount = 0; // Reset step count

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen((StepCount event) {
      setState(() {
        stepCount = event.steps; // Update step count from pedometer
        // Update calculated values
        totalTime = formatElapsedTime(elapsedTime);
        distanceCovered = (stepCount / stepsPerMile).toStringAsFixed(2) + ' miles';
        caloriesBurned = ((stepCount / stepsPerMile) * kcalPerMile).toStringAsFixed(0) + ' Kcal';
      });
    });

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (isRunning) {
        setState(() {
          elapsedTime++; // Increment elapsed time
        });
      }
    });
  }

  void stopRunning() {
    isRunning = false; // Stop running
  }

  String formatElapsedTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    return '${hours}h ${minutes}m';
  }

  @override
  void initState() {
    super.initState();

    dashboardController.fetchUserData(); // Fetch user data from the controller

    fetchFollowedUsers(); // Fetch the followed users
    fetchUsers(); // Fetch users when the widget is initialized

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
          title: Row(children: [
            CircularImage(imageUrl: dashboardController.imageUrl!, size: 50,) ,
            SizedBox(width: 6,),
            SimpleTextWidget(text: dashboardController.name!, fontWeight: FontWeight.w400, fontSize: 14, color: dark ? Colors.white : AppColor.black
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
                Container(
                  width: MyAppHelperFunctions.screenWidth() * 0.95,
                  height: 150,
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
                              label: caloriesBurned, // Updated to show calories
                              value: 'Kcal',
                            ),
                            ProgressContainer(
                              iconPath: AppImagePaths.clock,
                              label: totalTime, // Updated to show elapsed time
                              value: 'Time',
                            ),
                            ProgressContainer(
                              iconPath: AppImagePaths.location,
                              label: stepCount.toString(), // Updated to show steps
                              value: 'Steps',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.inputFieldRadius),
                // Container for Motivation
                Container(
                  width: MyAppHelperFunctions.screenWidth() * 0.95,
                  height: 120,
                  decoration: BoxDecoration(
                    color: dark ? AppColor.grey.withOpacity(0.1) : AppColor.grey.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SimpleTextWidget(
                          text: 'Ready to move forward, Kami?',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: dark ? AppColor.white : AppColor.black,
                          fontFamily: 'Poppins',
                          align: TextAlign.start,
                        ),
                        SimpleTextWidget(
                          text: 'Every step brings you closer to your goals—keep moving and stay motivated!',
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                          color: dark ? AppColor.white : AppColor.black,
                          fontFamily: 'Poppins',
                          align: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (!isRunning) {
                                startRunning(); // Start running if not already running
                              } else {
                                stopRunning(); // Stop running if already running
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: MyAppHelperFunctions.screenWidth() * 0.5,
                              decoration: BoxDecoration(
                                color: AppColor.orangeColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: SimpleTextWidget(
                                align: TextAlign.center,
                                text: isRunning ? 'Stop Run' : 'Record a Run',
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
                  ),
                ),

//
//                 Container(
//                   width: MyAppHelperFunctions.screenWidth() * 0.95,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: dark ? AppColor.grey.withOpacity(0.1) : AppColor.grey.withOpacity(0.3),
//                     borderRadius: const BorderRadius.all(Radius.circular(6)),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SimpleTextWidget(
//                           text: 'Your weekly progress',
//                           fontWeight: FontWeight.w300,
//                           fontSize: 13,
//                           color: dark ? AppColor.white : AppColor.black,
//                           fontFamily: 'Poppins',
//                           align: TextAlign.start,
//                         ),
//                         const SizedBox(height: 8), // Add space between the text and the row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly
//                           children: [
//
//
//
//                             ProgressContainer(
//                               iconPath: AppImagePaths.kcalicon,
//                               label: '$kcalPerMile',
//                               value: 'Kcal',
//                             ),
//                             ProgressContainer(
//                               iconPath: AppImagePaths.clock,
//                               label: '$totalTime',
//                               value: 'Time',
//                             ),
//                             ProgressContainer(
//                               iconPath: AppImagePaths.location,
//                               label: '$stepsPerMile',
//                               value: 'Distance',
//                             ),
//
//
//
//
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//                 ,
//                 const SizedBox(height: AppSizes.inputFieldRadius),
//
//
//                 Container(
//                   width: MyAppHelperFunctions.screenWidth() * 0.95,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: dark ? AppColor.grey.withOpacity(0.1) : AppColor.grey.withOpacity(0.3),
//                     borderRadius: const BorderRadius.all(Radius.circular(6)),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the start
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space between children
//                       children: [
//                         SimpleTextWidget(
//                           text: 'Ready to move forward, Kami?',
//                           fontWeight: FontWeight.w500,
//                           fontSize: 12,
//                           color: dark ? AppColor.white : AppColor.black,
//                           fontFamily: 'Poppins',
//                           align: TextAlign.start,
//                         ),
//                         SimpleTextWidget(
//                           text: 'Every step brings you closer to your goals—keep moving and stay motivated!',
//                           fontWeight: FontWeight.w300,
//                           fontSize: 10,
//                           color: dark ? AppColor.white : AppColor.black,
//                           fontFamily: 'Poppins',
//                           align: TextAlign.start,
//                         ),
//                         const SizedBox(height: 8),
//                         // Center the button in the remaining space
//                         Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               if (!isRunning) {
//                                 startRunning(); // Start running if not already running
//                               } else {
//                                 stopRunning(); // Stop running if already running
//                               }
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               height: 30,
//                               width: MyAppHelperFunctions.screenWidth() * 0.5,
//                               decoration: BoxDecoration(
//                                 color: AppColor.orangeColor,
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: SimpleTextWidget(
//                                 align: TextAlign.center,
//                                 text: isRunning ? 'Stop Run' : 'Record a Run',
//                                 fontWeight: FontWeight.w300,
//                                 fontSize: 12,
//                                 color: dark ? AppColor.black : AppColor.white,
//                                 fontFamily: 'Poppins',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
// ,
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
          final followedUserImageUrl = value['imageUrl'] ?? placeholderImageUrl;

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
          final userImageUrl = value['imageUrl'] ?? placeholderImageUrl; // Get image URL or use placeholder

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
