import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/profile/user_profile_main/widgets/ButtonsWidget.dart';
import 'package:fitness/screens/profile/user_profile_main/widgets/UserFollowingPostWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/CircularImage.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppSizes.dart';
import '../../../../utils/helpers/MyAppHelper.dart';
import '../../authentications/login_screen/LoginScreen.dart';
import '../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});
  Future<String?> fetchUserImageUrl(String userId) async {
    // Reference to the Firebase Realtime Database
    DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$userId');

    // Get the user data
    final snapshot = await userRef.get();
    if (snapshot.exists) {
      // Check if the imageUrl field exists in the user data
      return snapshot.child('imageUrl').value as String?;
    }
    return null; // Return null if the user doesn't exist or doesn't have an image URL
  }
  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    fetchUserCounts();
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? ''; // Get the current user's ID

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: dark ? AppColor.white : AppColor.black),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
                icon: const Icon(Icons.menu),
              ),
            )
          ],
          title: SimpleTextWidget(
            text: 'basit',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: "Poppins",
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                child: Text(
                  'Account Options',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Saved'),
                onTap: () {
                  // Handle Saved action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Account Privacy'),
                onTap: () {
                  // Handle Account Privacy action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Public'),
                onTap: () {
                  // Handle Public action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Comments'),
                onTap: () {
                  // Handle Comments action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Invite Friends'),
                onTap: () {
                  // Handle Invite Friends action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Share Profile'),
                onTap: () {
                  // Handle Share Profile action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Change Password'),
                onTap: () {
                  // Handle Change Password action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('About'),
                onTap: () {
                  // Handle About action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: const Text('Log Out'),
                onTap: () async {
                  try {
                    // Sign out from Firebase
                    await FirebaseAuth.instance.signOut();

                    // Navigate to the LoginScreen or another relevant screen
                    Get.offAll(() => const LoginScreen()); // Replace with your login screen

                  } catch (e) {
                    // Handle any errors that might occur during logout
                    print('Error logging out: $e');
                  }
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),


                FutureBuilder<String?>(
                  future: fetchUserImageUrl(userId), // Fetch user image URL
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Handle error
                    } else {
                      // If image URL exists, show it; otherwise, show placeholder
                      return CircularImage(
                        imageUrl: snapshot.data ?? 'https://via.placeholder.com/100', // Placeholder image
                        size: 100,
                      );
                    }
                  },
                ),

                const SizedBox(height: 4),
                SimpleTextWidget(
                  text: '@knc sors',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: dark ? AppColor.white : AppColor.black,
                  fontFamily: 'Poppins',
                ),
                const SizedBox(height: AppSizes.spaceBtwSections - 20),
                FutureBuilder<Map<String, int>>(
                  future: fetchUserCounts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Show loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Handle error
                    } else {
                      // Pass the fetched counts to the widget
                      final data = snapshot.data ?? {'posts': 0, 'followers': 0, 'following': 0};
                      return UserFollowingPostWidget(
                        dark: dark,
                        post: data['posts'].toString(),
                        followers: data['followers'].toString(),
                        following: data['following'].toString(),
                      );
                    }
                  },
                ),

                // UserFollowingPostWidget(dark: dark, post: '', followers: '', following: '',),
                const SizedBox(height: AppSizes.spaceBtwSections - 10),
                ButtonsWidget(dark: dark),
                const SizedBox(height: 20),
                TabBar(
                  tabs: const [
                    Tab(icon: Icon(Icons.photo)),
                    Tab(icon: Icon(Icons.slow_motion_video_rounded)),
                    Tab(icon: Icon(Icons.save)),
                  ],
                  indicatorColor: Colors.orange, // Set the indicator color to orange
                  labelColor: Colors.orange, // Set the color of the selected tab text/icon
                  unselectedLabelColor: dark ? AppColor.white : AppColor.black, // Set color for unselected tabs
                  indicatorSize: TabBarIndicatorSize.label,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                  height: MediaQuery.of(context).size.height - 250, // Adjust as needed
                  child: TabBarView(
                    children: [
                      DynamicHeightGridView(
                        itemCount: 120,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        builder: (ctx, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                            height: 100,
                            width: 50,
                            color: Colors.red,
                          );
                        },
                      ),
                      DynamicHeightGridView(
                        itemCount: 120,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        builder: (ctx, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                            height: 100,
                            width: 50,
                            color: Colors.yellow,
                          );
                        },
                      ),
                      DynamicHeightGridView(
                        itemCount: 120,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        builder: (ctx, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                            height: 100,
                            width: 50,
                            color: Colors.red,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<Map<String, int>> fetchUserCounts() async {
    // Get the current user's ID
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Reference to the user's data in Firebase Realtime Database
    DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$userId');

    // Fetch the data
    final DataSnapshot snapshot = await userRef.get();

    if (snapshot.exists) {
      // Count the number of posts, followers, and following
      int postCount = (snapshot.child('posts').value as Map<dynamic, dynamic>?)?.length ?? 0;
      int followersCount = (snapshot.child('followers').value as Map<dynamic, dynamic>?)?.length ?? 0;
      int followingCount = (snapshot.child('following').value as Map<dynamic, dynamic>?)?.length ?? 0;

      // Return a map containing the counts
      return {
        'posts': postCount,
        'followers': followersCount,
        'following': followingCount,
      };
    } else {
      // Return zeros if no data exists
      return {
        'posts': 0,
        'followers': 0,
        'following': 0,
      };
    }
  }
}
