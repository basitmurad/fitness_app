import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../authentication_screens/screens/login_screen/LoginScreen.dart';

class GenderService {
  Future<String> fetchUserGender() async {
    final User? user = FirebaseAuth.instance.currentUser; // Get the current user
    String gender = 'male'; // Default value for gender

    if (user == null) {
      // Handle the case when no user is logged in
      Get.to(() => const LoginScreen());
      throw Exception('User not logged in');
    }

    String userId = user.uid; // Get user ID
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      DataSnapshot snapshot = await databaseReference.child('users/$userId').get();

      if (snapshot.exists && snapshot.value is Map) {
        Map<Object?, Object?> userData = snapshot.value as Map<Object?, Object?>;
        gender = userData['gender'] as String? ?? gender; // Update gender if found
        print('your gender is $gender');
        // } else {
        debugPrint("No user data found or data is not in the expected format.");
      }
    } catch (e) {
      debugPrint('Error fetching user gender: ${e.toString()}');
    }

    return gender; // Return the determined gender
  }
}
