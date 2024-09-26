// // import 'package:fitness/screens/authentications/onboarding_screen/Onboarding.dart';
// // import 'package:fitness/screens/exercise_screen/exercise_start_screen/ExerciseProgressScreen.dart';
// // import 'package:fitness/screens/home/dashboard/Dashboard.dart';
// // import 'package:fitness/utils/helpers/KeyboardController.dart';
// // import 'package:fitness/utils/theme/MyAppTheme.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// //
// // void main() async {
// //
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //       options: DefaultFirebaseOptions.currentPlatform
// //   );
// //   // Get.put(KeyboardController());
// //   // Get.config(
// //   //   enableLog: true, // Enable logging for debugging
// //   // );
// //   // // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
// //   // //   statusBarColor: Colors.white, // Set your desired color
// //   // //   statusBarIconBrightness: Brightness.light, // Set the icon color (light or dark)
// //   // // ));
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetMaterialApp(
// //         themeMode: ThemeMode.system,
// //         theme: MyAppTheme.lightTheme,
// //         darkTheme: MyAppTheme.darkTheme,
// //         debugShowCheckedModeBanner: false,// Us
// //         home:   const OnboardingScreen());
// //
// //   }
// // }
// //
// //
// import 'package:fitness/screens/authentication_controllers/SignUpScreenController.dart';
// import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
// import 'package:fitness/screens/authentications/onboarding_screen/Onboarding.dart';
// import 'package:fitness/screens/home/dashboard/Dashboard.dart';
// import 'package:fitness/utils/helpers/KeyboardController.dart';
// import 'package:fitness/utils/theme/MyAppTheme.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // Import the generated options file
// import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.put(KeyboardController());
//
//   Get.config(
//     enableLog: true, // Enable logging
//   );
//
//   // Initialize Firebase
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform, // Use the generated options
//   );
//   print('Firebase initialized');
//
//   // Check if user is logged in
//
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//
//     return GetMaterialApp(
//         debugShowCheckedModeBanner: false, // Hide the debug banner
//
//         title: 'Flutter Demo',
//         theme: MyAppTheme.lightTheme  ,
//
//         home:  const AuthChecker()
//     );
//   }
// }
//
//
// class AuthChecker extends StatelessWidget {
//   const AuthChecker({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else {
//           if (snapshot.hasData && snapshot.data != null) {
//             // User is logged in, navigate to dashboard
//             print("user is not null $snapshot");
//
//             return  const Dashboard();
//           } else {
//             // User is not logged in, navigate to sign-in screen
//             print("user is null $snapshot");
//
//             return const LoginScreen();
//             print("user is not $snapshot");
//
//           }
//         }
//       },
//     );
//   }
// }
//
//
// // class MyApp extends StatelessWidget {
// //
// //    MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetMaterialApp(
// //       themeMode: ThemeMode.system,
// //       theme: MyAppTheme.lightTheme,
// //       darkTheme: MyAppTheme.darkTheme,
// //       debugShowCheckedModeBanner: false,
// //       home: user != null ? Dashboard() : OnboardingScreen(),
// //     );
// //   }
// // }
import 'package:fitness/navigation_menu.dart';
import 'package:fitness/screens/authentication_controllers/SignUpScreenController.dart';
import 'package:fitness/screens/authentications/login_screen/LoginScreen.dart';
import 'package:fitness/screens/authentications/onboarding_screen/Onboarding.dart';
import 'package:fitness/utils/helpers/KeyboardController.dart';
import 'package:fitness/utils/theme/MyAppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the generated options file
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(KeyboardController());

  Get.config(
    enableLog: true, // Enable logging for debugging
  );

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use the generated options
  );
  print('Firebase initialized');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        theme: MyAppTheme.lightTheme,
        darkTheme: MyAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,// Us
        home:    AuthChecker());
  }
}

// class AuthChecker extends StatelessWidget {
//   const AuthChecker({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else if (snapshot.hasData && snapshot.data != null) {
//           // User is logged in, navigate to dashboard
//           print("User is logged in: $snapshot");
//           return const NavigationMenu();
//         } else {
//           // User is not logged in, navigate to login screen
//           print("User is not logged in: $snapshot");
//           return const LoginScreen();
//         }
//       },
//     );
//   }
// }
class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          // User is logged in, navigate to navigation menu with user
          User user = snapshot.data!; // Get the logged-in user
          print("User is logged in: $snapshot");
          return NavigationMenu(user: user); // Pass user to NavigationMenu
        } else {
          // User is not logged in, navigate to login screen
          print("User is not logged in: $snapshot");
          return const LoginScreen();
        }
      },
    );
  }
}
