import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../authentications/login_screen/LoginScreen.dart';
import 'PostController.dart';

class DashboardController extends GetxController{

  var currentIndex = 0.obs; // Observable integer to hold the current index

  void setIndex(int index) {
    currentIndex.value = index; // Update the current index
  }

  final pageController = PageController();
  RxInt currentPageIndex = 0.obs;
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<String> fetchUserGender() async {
    final user = FirebaseAuth.instance.currentUser;
    String gender = 'male'; // Default value for gender

    if (user == null) {
      // If user is not logged in, navigate to login screen
      Get.to(() => const LoginScreen());
      throw Exception('User not logged in');
    }

    String userId = user.uid; // Get user ID
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      DataSnapshot snapshot = await databaseReference.child('users/$userId').get();

      if (snapshot.exists && snapshot.value is Map) {
        Map<Object?, Object?> userData = snapshot.value as Map<Object?, Object?>;
        gender = userData['gender'] as String? ?? gender;

        print('gender $gender');// Update gender if found
      } else {
        debugPrint("No user data found or data is not in the expected format.");
      }
    } catch (e) {
      debugPrint('Error fetching user gender: ${e.toString()}');
    }

    return gender; // Return the determined gender
  }





}