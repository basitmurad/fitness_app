// // import 'package:flutter/material.dart';
// //
// // class EmailVerificationScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Email Verification'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             // Email icon at the top center
// //             const Icon(
// //               Icons.email,
// //               size: 100,
// //               color: Colors.blue,
// //             ),
// //             const SizedBox(height: 20),
// //
// //             // Title
// //             const Text(
// //               'Verify Your Email',
// //               style: TextStyle(
// //                 fontSize: 24,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             const SizedBox(height: 10),
// //
// //             // Subtitle
// //             Text(
// //               'We have sent a verification link to your email.',
// //               textAlign: TextAlign.center,
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 color: Colors.grey[600],
// //               ),
// //             ),
// //             const SizedBox(height: 40),
// //
// //             // Verify button
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Add your verification logic here
// //               },
// //               child: const Text('Verify'),
// //               style: ElevatedButton.styleFrom(
// //                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //
// //             // Resend button
// //             TextButton(
// //               onPressed: () {
// //                 // Add your resend logic here
// //               },
// //               child: const Text('Resend Verification Email'),
// //             ),
// //             const SizedBox(height: 10),
// ////               onPressed: () {
// // //                 // Navigate back to login screen
// // //                 Navigator.of(context).pop();
// // //               },
// // //               child: const Text('Back to Login'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //             // Back to Login button
// //             TextButton(
//
// import 'package:fitness/screens/authentications/select_gender_screen/SelectGenderScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart'; // Update with your actual import
//
// class EmailVerificationScreen extends StatefulWidget {
//   final String email;
//   final String password;
//   @override
//   _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
// }
//
// class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkEmailVerification();
//   }
//
//   Future<void> _checkEmailVerification() async {
//     User? user = firebaseAuth.currentUser;
//
//     // Check if the user is not null and their email is verified
//     if (user != null) {
//       // Polling every 5 seconds to check if the email is verified
//       while (!user!.emailVerified) {
//         await Future.delayed(Duration(seconds: 5));
//         await user.reload(); // Refresh user info
//         user = firebaseAuth.currentUser; // Get updated user
//       }
//
//       // Navigate to the login screen or home screen after verification
//       Get.to(SelectGenderScreen(email: email, password: password)); // Update with your actual home or login screen
//     }
//   }
//
//   Future<void> _resendVerificationEmail() async {
//     User? user = firebaseAuth.currentUser;
//
//     if (user != null) {
//       await user.sendEmailVerification();
//       _showSnackbar('Verification email sent. Please check your inbox.');
//     }
//   }
//
//   void _showSnackbar(String message) {
//     Get.snackbar(
//       'Info',
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.blue,
//       colorText: Colors.white,
//       duration: Duration(seconds: 3),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Email Verification'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.email,
//               size: 100,
//               color: Colors.blue,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Verify Your Email',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'We have sent a verification link to your email.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: _checkEmailVerification,
//               child: const Text('Verify'),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: _resendVerificationEmail,
//               child: const Text('Resend Verification Email'),
//             ),
//             const SizedBox(height: 10),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Back to Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../select_gender_screen/SelectGenderScreen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String password;

  EmailVerificationScreen({required this.email, required this.password});

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

    if (user != null) {
      while (!user!.emailVerified) {
        await Future.delayed(const Duration(seconds: 5));
        await user.reload();
        user = firebaseAuth.currentUser;
      }

      // Navigate to the SelectGenderScreen after verification
      Get.to(SelectGenderScreen(email: widget.email, password: widget.password));
    }
  }

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
      backgroundColor: AppColor.orangeColor,
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
              child: const Text('Verify'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _resendVerificationEmail,
              child: const Text('Resend Verification Email'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
