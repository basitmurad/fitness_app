
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/navigation_menu.dart';
import 'package:fitness/screens/authentication_screens/screens/login_screen/LoginScreen.dart';
import 'package:fitness/utils/helpers/KeyboardController.dart';
import 'package:fitness/utils/theme/MyAppTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the generated options file
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(KeyboardController());

  Get.config(
    enableLog: true,
  );

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


class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  Future<bool> _checkUserExistsInDatabase(String uid) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$uid').get();
    return snapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;
          print("User is logged in: ${user.uid}");

          // Now check in Realtime Database
          return FutureBuilder<bool>(
            future: _checkUserExistsInDatabase(user.uid),
            builder: (context, dbSnapshot) {
              if (dbSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (dbSnapshot.hasData && dbSnapshot.data == true) {
                return NavigationMenu(user: user); // ✅ User found
              } else {
                // ❌ User not found in database
                FirebaseAuth.instance.signOut(); // Optional: sign out if user record not found
                return const LoginScreen();
              }
            },
          );
        } else {
          print("User is not logged in.");
          return const LoginScreen();
        }
      },
    );
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
//           User user = snapshot.data!; // Get the logged-in user
//           print("User is logged in: $snapshot");
//           return NavigationMenu(user: user); // Pass user to NavigationMenu
//         } else {
//           print("User is not logged in: $snapshot");
//           return const LoginScreen();
//         }
//       },
//     );
//   }
// }
