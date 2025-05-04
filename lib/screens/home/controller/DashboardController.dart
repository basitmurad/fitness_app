import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardController extends GetxController {
  // Observable variables for user data
  RxString name = ''.obs;
  RxString imageUrl = ''.obs;
  RxString gender = ''.obs;

  // Step counting and fitness tracking variables
  RxInt stepCount = 0.obs;
  RxList<int> weeklySteps = List<int>.filled(7, 0).obs;
  RxDouble distance = 0.0.obs;
  Rx<Duration> elapsedTime = Duration.zero.obs;

  // Tracking state variables
  RxBool isTracking = false.obs;
  int? baselineStepCount;
  int currentDayIndex = DateTime.now().weekday - 1;
  static const int dailyStepTarget = 20000;

  // For step tracking
  Stream<StepCount>? _stepCountStream;
  StreamSubscription<StepCount>? _stepCountSubscription;
  Timer? _timer;

  // For following users
  RxList<Map<String, dynamic>> followingUsersList = <Map<String, dynamic>>[].obs;
  RxBool isLoadingFollowing = true.obs;

  // For other users (to follow)
  RxList<Map<String, dynamic>> usersList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredUsersList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    requestPermissions();
    fetchFollowedUsers();
    fetchUsers();
  }

  @override
  void onClose() {
    _stepCountSubscription?.cancel();
    _timer?.cancel();
    super.onClose();
  }

  // User data fetching methods
  Future<void> fetchUserData() async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final DatabaseReference userRef =
        FirebaseDatabase.instance.ref('users/${currentUser.uid}');

        final snapshot = await userRef.get();
        if (snapshot.exists) {
          final userData = snapshot.value as Map<dynamic, dynamic>?;
          if (userData != null) {
            name.value = userData['name'] ?? '';
            imageUrl.value = userData['imageUrl'] ?? '';
            gender.value = userData['gender'] ?? '';
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }

  Future<String> fetchUserGender() async {
    try {
      if (gender.value.isEmpty) {
        await fetchUserData();
      }
      return gender.value;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user gender: $e');
      }
      return '';
    }
  }

  // Permission handling methods
  Future<void> requestPermissions() async {
    if (await Permission.activityRecognition.request().isGranted) {
      if (kDebugMode) {
        print("Activity recognition permission granted");
      }
      initializePedometer();
    } else {
      if (kDebugMode) {
        print("Activity recognition permission not granted");
      }
    }
  }

  // Step tracking methods
  void startListening() async {
    if (await Permission.activityRecognition.isGranted) {
      if (kDebugMode) {
        print("Start Tracking.");
      }

      initializePedometer();
      startTimer();
    } else {
      if (kDebugMode) {
        print("Activity recognition permission is not granted.");
      }
    }
  }

  Future<void> initializePedometer() async {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountSubscription = _stepCountStream!.listen(
          (event) {
        if (kDebugMode) {
          print("Steps detected: ${event.steps}");
        }
        onStepCount(event);
      },
      onError: (error) {
        if (kDebugMode) {
          print("Step count error: $error");
        }
      },
    );
  }

  void onStepCount(StepCount event) {
    int todayIndex = DateTime.now().weekday - 1;
    baselineStepCount ??= event.steps;

    if (todayIndex != currentDayIndex) {
      currentDayIndex = todayIndex;
      baselineStepCount = event.steps;
      weeklySteps[currentDayIndex] = 0;
      stepCount.value = 0;
      distance.value = 0.0;
      elapsedTime.value = Duration.zero;
    }

    if (baselineStepCount != null) {
      int calculatedSteps = event.steps - baselineStepCount!;
      if (calculatedSteps != weeklySteps[currentDayIndex]) {
        weeklySteps[currentDayIndex] = calculatedSteps;
        stepCount.value = calculatedSteps;
        distance.value = calculatedSteps * 0.762; // Average stride length in meters
      }
    }

    double caloriesBurned = calculateCalories(stepCount.value);
    if (kDebugMode) {
      print('Calories burned: $caloriesBurned');
    }
  }

  void stopListening() async {
    if (kDebugMode) {
      print('tracking value is ${isTracking.value}');
    }

    // Save tracking data to Firebase
    String userID = FirebaseAuth.instance.currentUser!.uid;
    double caloriesBurned = calculateCaloriesBurned(stepCount.value);
    int timeTracked = calculateTimeTracked();

    // Get the current day name
    String dayName = getCurrentDayName();

    // Firebase reference to track steps for the user on the current day
    DatabaseReference trackingRef =
    FirebaseDatabase.instance.ref('Tracking/$userID/$dayName');

    // Fetch the existing step count data for the current day
    DatabaseEvent event = await trackingRef.once();
    DataSnapshot snapshot = event.snapshot;

    // Safely cast the snapshot value to Map<String, dynamic>
    Map<String, dynamic> existingData = (snapshot.value is Map)
        ? Map<String, dynamic>.from(snapshot.value as Map)
        : {};

    // Get the previous values if they exist
    int previousSteps = existingData['steps'] ?? 0;
    double previousCalories = existingData['caloriesBurned'] ?? 0.0;
    int previousTimeTracked = existingData['timeTracked'] ?? 0;

    // Add the new values to the previous values
    int newStepCount = previousSteps + stepCount.value;
    double newCaloriesBurned = previousCalories + caloriesBurned;
    int newTimeTracked = previousTimeTracked + timeTracked;

    // Prepare the updated data
    Map<String, dynamic> data = {
      'steps': newStepCount,
      'caloriesBurned': newCaloriesBurned,
      'timeTracked': newTimeTracked,
    };

    // Update the database with the new data
    trackingRef.set(data).then((_) {
      if (kDebugMode) {
        print("Footstep tracking data updated for $dayName.");
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("Failed to update data: $error");
      }
    });

    // Stop the subscription and clean up
    _stepCountSubscription?.cancel();
    _stepCountSubscription = null;
    _stepCountStream = null;
    stopTimer();

    if (kDebugMode) {
      print("Stopped tracking footsteps and cleared pedometer stream.");
    }
  }

  // Timer methods
  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedTime.value += const Duration(seconds: 1);
    });
    isTracking.value = true;
  }

  void stopTimer() {
    _timer?.cancel();
    isTracking.value = false;
  }

  void onResumeTracking() {
    isTracking.value = true;
    startListening();
  }

  // Calculation methods
  double calculateCalories(int steps) {
    const double caloriesPerStep = 0.04; // Estimated calories per step
    double calories = steps * caloriesPerStep;
    return double.parse(calories.toStringAsFixed(4));
  }

  double calculateCaloriesBurned(int steps) {
    // Using the same formula as calculateCalories
    double caloriesPerStep = 0.04;
    return steps * caloriesPerStep;
  }

  int calculateTimeTracked() {
    // Return the total time in seconds
    return elapsedTime.value.inSeconds;
  }

  String formatElapsedTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return "$hours:${twoDigits(minutes)}:${twoDigits(seconds)}";
  }

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

  // Following users methods
  Future<void> fetchFollowedUsers() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
      return;
    }

    final DatabaseReference followingRef =
    FirebaseDatabase.instance.ref('users/${currentUser.uid}/following');

    isLoadingFollowing.value = true;

    followingRef.onValue.listen((DatabaseEvent event) {
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        final Map<dynamic, dynamic> followingMap =
        dataSnapshot.value as Map<dynamic, dynamic>;

        followingUsersList.clear();

        followingMap.forEach((key, value) {
          final followedUserId = key;
          final followedUserName = value['name'];
          final followedUserImageUrl =
              value['imageUrl'] ?? AppImagePaths.placeholder1;

          followingUsersList.add({
            'id': followedUserId,
            'name': followedUserName,
            'imageUrl': followedUserImageUrl,
          });
        });

        if (kDebugMode) {
          print('Followed users found: $followingUsersList');
        }

        isLoadingFollowing.value = false;
      } else {
        if (kDebugMode) {
          print('No followed users found.');
        }
        isLoadingFollowing.value = false;
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('Error fetching followed users: $error');
      }
      isLoadingFollowing.value = false;
    });
  }

  Future<void> fetchUsers() async {
    final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
      return;
    }

    usersRef.onValue.listen((DatabaseEvent event) {
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        final Map<dynamic, dynamic> usersMap =
        dataSnapshot.value as Map<dynamic, dynamic>;

        usersList.clear();

        usersMap.forEach((key, value) {
          final userId = key;
          final userName = value['name'];
          final userImageUrl = value['imageUrl'] ?? AppImagePaths.placeholder1;

          if (userId != currentUser.uid && !_isUserFollowed(userId)) {
            usersList.add({
              'id': userId,
              'name': userName,
              'imageUrl': userImageUrl,
            });
          }
        });

        filteredUsersList.value = List.from(usersList);

      } else {
        if (kDebugMode) {
          print('No users found.');
        }
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('Error fetching users: $error');
      }
    });
  }

  bool _isUserFollowed(String userId) {
    return followingUsersList.any((user) => user['id'] == userId);
  }

  void onRemoveUser(String userId) {
    usersList.removeWhere((user) => user['id'] == userId);
    filteredUsersList.removeWhere((user) => user['id'] == userId);
  }

  Future<void> onFollowUser(
      String followedUserId, String followedUserName, String imageUrl) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
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
      // Update the current user's "following" node
      await currentUserRef.set({
        'id': followedUserId,
        'name': followedUserName,
        'imageUrl': imageUrl,
      });

      // Update the followed user's "followers" node
      await followedUserRef.set({
        'id': currentUser.uid,
        'name': currentUser.displayName ?? 'Unknown',
        'imageUrl': currentUser.photoURL ?? '',
      });

      if (kDebugMode) {
        print("Followed user $followedUserName and updated their followers list.");
      }

      // Update local lists after successful follow
      fetchFollowedUsers();
      fetchUsers();

    } catch (e) {
      if (kDebugMode) {
        print("Error following user: $e");
      }
    }
  }

  // App lifecycle handling
  void handleAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _stepCountSubscription?.isPaused == true) {
      _stepCountSubscription?.resume();
    } else if (state == AppLifecycleState.paused) {
      _stepCountSubscription?.pause();
    }
  }
}