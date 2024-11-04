
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/screens/authentications/select_gender_screen/SelectGenderScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String password;

  const EmailVerificationScreen({super.key, required this.email, required this.password});

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkEmailVerification();
  }
  Future<void> _checkEmailVerification() async {
    User? user = firebaseAuth.currentUser;
    int attempts = 0;
    const int maxAttempts = 12; // Check for 1 minute (12 x 5 seconds)

    if (user != null) {
      while (attempts < maxAttempts) {
        await Future.delayed(const Duration(seconds: 5));
        await user?.reload(); // Ensure this is only called if user is not null

        user = firebaseAuth.currentUser; // Refresh user to get updated properties
        if (user != null && user.emailVerified) {
          // Navigate to SelectGenderScreen after verification
          Get.off(() => SelectGenderScreen(email: widget.email, password: widget.password));
          return; // Exit the loop once verified
        }
        attempts++;
      }

      // If email is not verified after max attempts, show a message
      if (user != null && !user.emailVerified) {
        _showSnackbar('Email verification is still pending. Please try again later.');
      }
    } else {
      _showSnackbar('User is not logged in. Please sign in again.');
    }
  }


  // Future<void> _checkEmailVerification() async {
  //   User? user = firebaseAuth.currentUser;
  //
  //   if (user != null) {
  //     // Polling every 5 seconds to check if the email is verified
  //     while (!user!.emailVerified) {
  //       await Future.delayed(const Duration(seconds: 5));
  //       await user.reload();
  //       user = firebaseAuth.currentUser; // Get updated user
  //     }
  //
  //     // Navigate to SelectGenderScreen after verification
  //     Get.off(() => SelectGenderScreen(email: widget.email, password: widget.password));
  //   }
  // }

  Future<void> _resendVerificationEmail() async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      await user.sendEmailVerification();
      _showSnackbar('Verification email sent. Please check your inbox.');
    }
  }

  void _showSnackbar(String message) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.email,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Verify Your Email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'We have sent a verification link to your email.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _checkEmailVerification,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Verify'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _resendVerificationEmail,
              child: const Text('Resend Verification Email'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.back(); // Navigate back to the login screen
              },
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
