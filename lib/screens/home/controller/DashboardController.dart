import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentications/login_screen/LoginScreen.dart';
import '../../authentications/select_gender_screen/SelectGenderScreen.dart';
import '../../modelClass/UserData .dart';

class DashboardController extends GetxController{



  String? name = '';
  String? imageUrl = '';







  Future<String> fetchUserGender() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String gender = 'male'; // Default value for gender

    if (user == null) {
      Get.to(() => const LoginScreen());
      throw Exception('User not logged in');
    }

    String userId = user.uid;
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      DataSnapshot snapshot = await databaseReference.child('users/$userId').get();

      if (snapshot.exists && snapshot.value is Map) {
        Map<Object?, Object?> userData = snapshot.value as Map<Object?, Object?>;
        gender = userData['gender'] as String? ?? gender;

        print('Gender: $gender');
      } else {
        debugPrint("No user data found or data is not in the expected format.");
      }
    } catch (e) {
      debugPrint('Error fetching user gender: ${e.toString()}');
    }

    return gender;
  }


  Future<void> fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;

    String? userId = user?.uid; // Get user ID
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      DataSnapshot snapshot = await databaseReference.child('users/$userId').get();

      if (snapshot.exists && snapshot.value is Map) {
        Map<Object?, Object?> userDataMap = snapshot.value as Map<Object?, Object?>;

        // Create an instance of UserData from the retrieved data
        UserData userData = UserData(
          email: userDataMap['email'] as String?,
          name: userDataMap['name'] as String?,
          userFcmToken: userDataMap['userFcmToken'] as String?,
          gender: userDataMap['gender'] as String?,
          age: userDataMap['age'] as String?,
          height: userDataMap['height'] as String?,
          weight: userDataMap['weight'] as String?,
          targetWeight: userDataMap['targetWeight'] as String?,
          imageUrl: userDataMap['imageUrl'] as String?,
        );

        // Check for missing information
        if (userData.gender == null || userData.name!.isEmpty ||
            userData.age == null || userData.age!.isEmpty ||
            userData.height == null || userData.height!.isEmpty ||
            userData.weight == null || userData.weight!.isEmpty ||
            userData.targetWeight == null || userData.targetWeight!.isEmpty) {

          // Show Snackbar notification
          Get.snackbar(
            "Missing Information",
            "Some information is missing. Please select your gender.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );

          // Navigate to the Gender Selection screen
          Get.to(() => SelectGenderScreen(email: userData.email!, password: ''));
        } else {
          // If all data is present, do nothing or proceed as needed
          debugPrint('User Data is complete. No action required.');
          debugPrint('${userData.name} and ${userData.imageUrl}');

          name = userData.name;
          imageUrl = userData.imageUrl;
        }
      } else {
        debugPrint("No user data found or data is not in the expected format.");
      }
    } catch (e) {
      debugPrint('Error fetching user data: ${e.toString()}');
    }
  }




}

