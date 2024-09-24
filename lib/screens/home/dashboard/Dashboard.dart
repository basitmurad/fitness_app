import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/common/widgets/MyAppGridLayout.dart';
import 'package:fitness/screens/exercise_screen/abs_screen/AbsScreen.dart';
import 'package:fitness/screens/home/dashboard/widgets/ChallengedWidget.dart';
import 'package:fitness/screens/home/dashboard/widgets/ExerciseWidget.dart';
import 'package:fitness/screens/home/dashboard/widgets/FollowUserCard.dart';
import 'package:fitness/screens/home/dashboard/widgets/TextWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppSizes.dart';
import '../../authentications/login_screen/LoginScreen.dart';



List<Map<String, String>> maleExercise = [
  {
    'imagePath': AppImagePaths.maleAbsWorkout,
    'exerciseName': 'Abs Workout',
    'exerciseRepetition': '09 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleChestWorkout,
    'exerciseName': 'Chest Workout',
    'exerciseRepetition': '08 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleArmWorkout,
    'exerciseName': 'Arm Workout',
    'exerciseRepetition': '5 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleLegWorkout,
    'exerciseName': 'Leg Workout',
    'exerciseRepetition': '6 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleShoulderWorkout,
    'exerciseName': 'Shoulder Workout',
    'exerciseRepetition': '6 Exercise',
  },
  {
    'imagePath': AppImagePaths.maleBackWorkout,
    'exerciseName': 'Back Workout',
    'exerciseRepetition': '6',
  },
];
List<Map<String, String>> femaleExercises = [
  {
    'imagePath': AppImagePaths.femaleAbsWorkout,
    'exerciseName': 'Abs Workout',
    'exerciseRepetition': '09 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleChestWorkout,
    'exerciseName': 'Chest Workout',
    'exerciseRepetition': '08 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleArmWorkout,
    'exerciseName': 'Arm Workout',
    'exerciseRepetition': '5 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleLegWorkout,
    'exerciseName': 'Leg Workout',
    'exerciseRepetition': '6 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleShoulderWorkout,
    'exerciseName': 'Shoulder Workout',
    'exerciseRepetition': '6 Exercise',
  },
  {
    'imagePath': AppImagePaths.femaleBackWorkout,
    'exerciseName': 'Back Workout',
    'exerciseRepetition': '6',
  },
];
class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    late FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.dashboard),
        actions: [
          Image(
            width: 20,
            height: 20,
            color: dark ? AppColor.white : AppColor.black,
            image: const AssetImage(AppImagePaths.messages),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              firebaseAuth.signOut();
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: FollowUserCard(dark: dark),
                  );
                },
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),
              TextWidget(dark: dark),

              // Use FutureBuilder to handle the async gender fetching
              FutureBuilder<String>(
                future: _fetchUserGender(), // Call the gender fetching function
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
                    List<Map<String, String>> exercisesList = gender == 'female'
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
                              // Pass the exercise name when navigating to AbsScreen
                              Get.to(AbsScreen(
                                exerciseName:
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
    );
  }

  Future<String> _fetchUserGender() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String gender = 'male'; // Default value for gender

    if (user == null) {
      // If user is not logged in, navigate to login screen
      Get.to(() => LoginScreen());
      throw Exception('User not logged in');
    }

    String userId = user.uid; // Get user ID
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      DataSnapshot snapshot = await databaseReference.child('users/$userId').get();

      if (snapshot.exists && snapshot.value is Map) {
        Map<Object?, Object?> userData = snapshot.value as Map<Object?, Object?>;
        gender = userData['gender'] as String? ?? gender; // Update gender if found
      } else {
        debugPrint("No user data found or data is not in the expected format.");
      }
    } catch (e) {
      debugPrint('Error fetching user gender: ${e.toString()}');
    }

    return gender; // Return the determined gender
  }
}


// class Dashboard extends StatelessWidget {
//   const Dashboard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final bool dark = MyAppHelperFunctions.isDarkMode(context);
//
//     late FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//    late String gender1 ='';
//     _checkUserData(context);
//
//     final GenderService genderService = GenderService();
//     // List<Map<String, String>> exercisesList = maleExercise; // Default to male exercises
//
//     genderService.fetchUserGender().then((fetchedGender) {
//       gender1=fetchedGender;
//       // exercisesList = fetchedGender == 'female' ? femaleExercises : maleExercise;
//       // Call setState or similar to refresh UI if necessary
//     });
//
//     List<Map<String, String>> exercisesList = gender1 == 'female'
//         ? femaleExercises
//         : maleExercise;
//
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(AppStrings.dashboard),
//         actions: [
//           Image(
//             width: 20,
//             height: 20,
//             color: dark ? AppColor.white : AppColor.black,
//             image: const AssetImage(AppImagePaths.messages),
//           ),
//           const SizedBox(width: 8),
//           GestureDetector(
//             onTap: (){
//               firebaseAuth.signOut();
//
//             },
//             child: Image(
//               width: 20,
//               height: 20,
//               color: dark ? AppColor.white : AppColor.black,
//               image: const AssetImage(AppImagePaths.notification),
//             ),
//           ),
//           const SizedBox(width: 8.0),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: AppSizes.inputFieldRadius,
//               ),
//               ChallengedWidget(dark: dark),
//               const SizedBox(
//                 height: AppSizes.inputFieldRadius - 5,
//               ),
//               Text(
//                 AppStrings.fitnessTitans,
//                 style: Theme
//                     .of(context)
//                     .textTheme
//                     .titleMedium
//                     ?.copyWith(
//                     color: dark ? AppColor.white : AppColor.black,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w400),
//               ),
//               const SizedBox(
//                 height: AppSizes.inputFieldRadius,
//               ),
//               MyAppGridLayout(
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: FollowUserCard(dark: dark),
//                     );
//                   }),
//               const SizedBox(
//                 height: AppSizes.spaceBtwInputFields,
//               ),
//               TextWidget(dark: dark),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: exercisesList.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.zero,
//                     child: GestureDetector(
//                       onTap: () {
//                         // Pass the exercise name when navigating to AbsScreen
//                         Get.to(AbsScreen(
//                           exerciseName: exercisesList[index]['exerciseName']!,
//                           exerciseRepititon: exercisesList[index]['exerciseRepetition']!,
//                           gender: genderService.toString(),));
//                       },
//                       child: ExerciseWidget(
//                         dark: dark,
//                         imagePath: exercisesList[index]['imagePath']!,
//                         exerciseName: exercisesList[index]['exerciseName']!,
//                         exerciseRepeation: exercisesList[index]['exerciseRepetition']!,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _checkUserData(BuildContext context) async {
//     final User? user = FirebaseAuth.instance.currentUser; // Get the current user
//     if (user == null) {
//       // Handle the case when no user is logged in
//       Get.to(() => const LoginScreen());
//       return;
//     }
//
//     String userId = user.uid; // Get user ID
//     final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
//
//     try {
//       DataSnapshot snapshot = await databaseReference.child('users/$userId').get();
//
//       if (snapshot.exists) {
//         // Check if the snapshot value is a Map
//         if (snapshot.value is Map) {
//           Map<Object?, Object?> userData = snapshot.value as Map<Object?, Object?>;
//           debugPrint("User Data: $userData"); // Log the entire user data
//
//           // Extract the required fields
//           String? gender = userData['gender'] as String?;
//           String? name = userData['name'] as String?;
//           int? age = int.tryParse(userData['age']?.toString() ?? '') ?? 0; // Convert to int
//           String? email = userData['email'] as String?;
//           String? height = userData['height'] as String?;
//           String? currentWeight = userData['weight'] as String?;
//           int? targetWeight = int.tryParse(userData['targetWeight']?.toString() ?? '') ?? null; // Convert to int
//
//           // Navigate based on the presence of data
//           if (email != null && email.isNotEmpty) {
//             if (gender == null || gender.isEmpty) {
//               debugPrint("Navigating to SelectGenderScreen");
//               Get.to(() => SelectGenderScreen(email: email, password: ''));
//             } else if (name == null || name.isEmpty) {
//               debugPrint("Navigating to NameScreen");
//               Get.to(() => NameScreen(email: email, gender: gender, password: '',));
//             } else if (age == 0) {
//               debugPrint("Navigating to DateOfBirthScreen");
//               Get.to(() => DateOfBirthScreen(email: email, password: '', gender: gender, name: name));
//             } else if (height == null) {
//               debugPrint("Navigating to HeightScreen");
//               Get.to(() => HeightScreen(email: email, password: '', gender: gender, name: name, year: age));
//             } else if (currentWeight == null || currentWeight.isEmpty) {
//               debugPrint("Navigating to WeightScreen");
//               Get.to(() => WeightScreen(email: email, password: '', gender: gender, name: name, height: height, year: age,));
//               debugPrint("Age: $age, Current Weight: $currentWeight, Target Weight: $targetWeight");
//
//
//             } else if (targetWeight == null) {
//               debugPrint("Navigating to TargetWeightScreen");
//               Get.to(() => TargetWeightScreen(email: email, password: '', gender: gender, name: name, height: height, currentWeight: currentWeight, year: age,));
//             } else {
//               // If all data is present, navigate to Dashboard and print user data
//               Get.to(const Dashboard());
//               debugPrint("User Data: Email: $email, Name: $name, Gender: $gender, Age: $age, Height: $height, Current Weight: $currentWeight, Target Weight: $targetWeight");
//             }
//           } else {
//             debugPrint("Email is missing.");
//           }
//         } else {
//           debugPrint("User data is not in the expected format.");
//         }
//       } else {
//         debugPrint("No user data found for this user ID.");
//       }
//     } catch (e) {
//       debugPrint('Error checking user data: ${e.toString()}');
//     }
//   }
//   Future<String> _fetchUserGender() async {
//     final User? user = FirebaseAuth.instance.currentUser; // Get the current user
//     String gender = 'male'; // Default value for gender
//
//     if (user == null) {
//       // Handle the case when no user is logged in
//       Get.to(() => LoginScreen());
//       throw Exception('User not logged in');
//     }
//
//     String userId = user.uid; // Get user ID
//     final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
//
//     try {
//       DataSnapshot snapshot = await databaseReference.child('users/$userId').get();
//
//       if (snapshot.exists && snapshot.value is Map) {
//         Map<Object?, Object?> userData = snapshot.value as Map<Object?, Object?>;
//         gender = userData['gender'] as String? ?? gender; // Update gender if found
//       } else {
//         debugPrint("No user data found or data is not in the expected format.");
//       }
//     } catch (e) {
//       debugPrint('Error fetching user gender: ${e.toString()}');
//     }
//
//     return gender; // Return the determined gender
//   }}