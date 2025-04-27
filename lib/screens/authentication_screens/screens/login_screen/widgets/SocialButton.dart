
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/authentication_screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../utils/constants/AppImagePaths.dart';
import 'package:fitness/navigation_menu.dart';
import 'package:get/get.dart';

import '../../../../modelClass/UserData .dart';
class SocialButton extends StatelessWidget {
  const SocialButton({super.key});

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Begin interactive sign-in process
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Close loading indicator
      Navigator.pop(context);

      if (googleUser == null) {
        // User canceled the sign-in flow
        Fluttertoast.showToast(msg: "Sign in cancelled");
        return;
      }

      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create new credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User user = userCredential.user!;

      // Extract user details
      final Map<String, dynamic> userData = {
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'phoneNumber': user.phoneNumber,
        'emailVerified': user.emailVerified,
      };

       await uploadUserDataToFirebase(name: user.displayName!, email: user.email!);

      // Show success message
      Fluttertoast.showToast(msg: "Signed in as ${user.displayName}");

      Get.offAll(() =>  ProfileScreen(name: user.displayName!,));

    } catch (e) {
      // Close loading indicator if it's still showing
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      // Show error message
      Fluttertoast.showToast(msg: "Sign in failed: ${e.toString()}");
      print("Google sign in error: $e");
    }
  }

  Future<void> uploadUserDataToFirebase({
    required String name,
    required String email,
  }) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    try {
      UserData userData = UserData(
        name: name,
        email: email,
      );

      await databaseReference.child('users/$userId').set(userData.toJson());
      debugPrint('Initial user data uploaded to Firebase: $userId');
    } catch (e) {
      debugPrint('Error uploading user data: ${e.toString()}');
      throw e; // Re-throw the error to be caught by the calling function
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => signInWithGoogle(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
              height: 36,
              width: 36,
              AppImagePaths.google
          ),
          const SizedBox(height: 6),
          Text(
            'Google',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
}