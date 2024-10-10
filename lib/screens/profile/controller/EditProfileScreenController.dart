// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:fitness/common/snackbar/ShowSnackbar.dart';
// import 'package:fitness/utils/constants/AppColor.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class EditProfileScreenController extends GetxController {
//   var name = ''.obs;
//
//
//   var username = ''.obs;
//   var bio = ''.obs;// Reactive variable to store the user's name
//   final TextEditingController editingController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Fetch initial name value if needed (e.g., from database)
//     // This is just an example; update this as per your logic
//     name.value = 'Current Username';
//   }
//   String? getCurrentUserId() {
//     User? user = FirebaseAuth.instance.currentUser;
//     return user?.uid; // This will return the userId or null if not authenticated
//   }
//   void showChangeNameDialog(BuildContext context) {
//     String? userId = getCurrentUserId();
//
//     editingController.text = name.value; // Pre-fill the current name in the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Change Name', style: TextStyle(fontFamily: "Poppins")),
//           content: TextField(
//             controller: editingController,
//             decoration: const InputDecoration(
//               labelText: 'Enter new name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: ()  async{
//                 if (editingController.text.isEmpty) {
//                   ShowSnackbar.showMessage(
//                     title: 'Empty',
//                     message: 'Please enter a name',
//                     backgroundColor: AppColor.error,
//                   );
//                 } else {
//                   name.value = editingController.text;
//                   await updateNameInDatabase(userId!, name.value);
// // Update the name
//                   // You can add a call to update the name in a database here
//                   Navigator.of(context).pop();
//                   ShowSnackbar.showMessage(
//                     title: 'Success',
//                     message: 'Name updated',
//                     backgroundColor: AppColor.success,
//                   );
//                 }
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//
//
//   // Reference to the database
//   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users'); // Update the path as necessary
//
//   // Method to fetch user details
//   Future<void> fetchUserDetails(String userId) async {
//     try {
//       // Listen for the value once
//       DatabaseEvent event = await _dbRef.child(userId).once();
//
//       // Access the snapshot from the event
//       DataSnapshot snapshot = event.snapshot;
//
//       if (snapshot.exists) {
//         var data = snapshot.value as Map<dynamic, dynamic>;
//         name.value = data['name'] ?? '';
//         username.value = data['username'] ?? '';
//         bio.value = data['bio'] ?? '';
//       } else {
//         // Handle case where user does not exist
//         print('User does not exist');
//       }
//     } catch (e) {
//       // Handle errors
//       print('Error fetching user details: $e');
//     }
//   }
//
//   Future<void> updateNameInDatabase(String userId, String newName) async {
//     try {
//       await _dbRef.child(userId).update({'name': newName});
//       print('Name updated in database successfully');
//     } catch (e) {
//       // Handle errors
//       print('Error updating name in database: $e');
//     }
//   }
//
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreenController extends GetxController {
  var name = ''.obs;
  var username = ''.obs;
  var bio = ''.obs; // Reactive variable to store the user's bio
  final TextEditingController editingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Fetch initial name value if needed (e.g., from database)
    name.value = 'Current Username';
    bio.value = 'Current Bio'; // Set the initial bio value
  }

  String? getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid; // This will return the userId or null if not authenticated
  }

  void showChangeNameDialog(BuildContext context) {
    String? userId = getCurrentUserId();
    editingController.text = name.value; // Pre-fill the current name in the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Name', style: TextStyle(fontFamily: "Poppins")),
          content: TextField(
            controller: editingController,
            decoration: const InputDecoration(
              labelText: 'Enter new name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (editingController.text.isEmpty) {
                  ShowSnackbar.showMessage(
                    title: 'Empty',
                    message: 'Please enter a name',
                    backgroundColor: AppColor.error,
                  );
                } else {
                  name.value = editingController.text;
                  await updateNameInDatabase(userId!, name.value);
                  Navigator.of(context).pop();
                  ShowSnackbar.showMessage(
                    title: 'Success',
                    message: 'Name updated',
                    backgroundColor: AppColor.success,
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showChangeBioDialog(BuildContext context) {
    String? userId = getCurrentUserId();
    editingController.text = bio.value; // Pre-fill the current bio in the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Bio', style: TextStyle(fontFamily: "Poppins")),
          content: TextField(
            controller: editingController,
            decoration: const InputDecoration(
              labelText: 'Enter new bio',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (editingController.text.isEmpty) {
                  ShowSnackbar.showMessage(
                    title: 'Empty',
                    message: 'Please enter a bio',
                    backgroundColor: AppColor.error,
                  );
                } else {
                  bio.value = editingController.text;
                  await updateBioInDatabase(userId!, bio.value);
                  Navigator.of(context).pop();
                  ShowSnackbar.showMessage(
                    title: 'Success',
                    message: 'Bio updated',
                    backgroundColor: AppColor.success,
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Reference to the database
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users'); // Update the path as necessary

  // Method to fetch user details
  Future<void> fetchUserDetails(String userId) async {
    try {
      // Listen for the value once
      DatabaseEvent event = await _dbRef.child(userId).once();
      // Access the snapshot from the event
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        var data = snapshot.value as Map<dynamic, dynamic>;
        name.value = data['name'] ?? '';
        username.value = data['username'] ?? '';
        bio.value = data['bio'] ?? '';
      } else {
        // Handle case where user does not exist
        print('User does not exist');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching user details: $e');
    }
  }

  Future<void> updateNameInDatabase(String userId, String newName) async {
    try {
      await _dbRef.child(userId).update({'name': newName});
      print('Name updated in database successfully');
    } catch (e) {
      // Handle errors
      print('Error updating name in database: $e');
    }
  }

  Future<void> updateBioInDatabase(String userId, String newBio) async {
    try {
      await _dbRef.child(userId).update({'bio': newBio});
      print('Bio updated in database successfully');
    } catch (e) {
      // Handle errors
      print('Error updating bio in database: $e');
    }
  }
}
