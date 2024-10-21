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
import '../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  Future<String?> fetchUserImageUrl(String userId) async {
    // Same as your existing method
    DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$userId');
    final snapshot = await userRef.get();
    return snapshot.exists ? snapshot.child('imageUrl').value as String? : null;
  }

  Future<List<String>> fetchAllPostImages(String userId) async {
    // Same as your existing method
    DatabaseReference postsRef = FirebaseDatabase.instance.ref('posts').child(userId);
    final snapshot = await postsRef.get();
    List<String> imageUrls = [];
    if (snapshot.exists) {
      Map<dynamic, dynamic> postsMap = snapshot.value as Map<dynamic, dynamic>;
      postsMap.forEach((key, value) {
        if (value['images'] != null) {
          List<dynamic> images = value['images'];
          imageUrls.addAll(List<String>.from(images));
        }
      });
    }
    return imageUrls; // Return the list of all image URLs
  }
  Future<int> fetchUserPostCount(String userId) async {
    DatabaseReference postsRef = FirebaseDatabase.instance.ref('posts').child(userId);
    final DataSnapshot snapshot = await postsRef.get();

    if (snapshot.exists) {
      return (snapshot.value as Map<dynamic, dynamic>).length; // Return the number of posts
    } else {
      return 0; // Return 0 if there are no posts
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

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
          title: SimpleTextWidget(
            text: 'basit',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: "Poppins",
          ),
        ),
        drawer: Drawer(
          // Drawer code remains unchanged
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                FutureBuilder<String?>(
                  future: fetchUserImageUrl(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularImage(
                        imageUrl: snapshot.data ?? 'https://via.placeholder.com/100',
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
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
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
                const SizedBox(height: AppSizes.spaceBtwSections - 10),
                ButtonsWidget(dark: dark),
                const SizedBox(height: 20),
                TabBar(
                  tabs: const [
                    Tab(icon: Icon(Icons.photo)),
                    // Tab(icon: Icon(Icons.slow_motion_video_rounded)),
                    Tab(icon: Icon(Icons.save)),
                  ],
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orange,
                  unselectedLabelColor: dark ? AppColor.white : AppColor.black,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                  height: MediaQuery.of(context).size.height - 250,
                  child: TabBarView(
                    children: [
                      FutureBuilder<List<String>>(
                        future: fetchAllPostImages(userId), // Fetch all post images
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            final imageUrls = snapshot.data ?? [];
                            return DynamicHeightGridView(
                              itemCount: imageUrls.length,
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              builder: (ctx, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                  height: 100,
                                  width: 50,
                                  child: Image.network(
                                    imageUrls[index],
                                    fit: BoxFit.cover, // Fit the image properly
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child; // Image loaded successfully
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                : null, // Show progress if possible
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error)), // Handle error
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),

                      // DynamicHeightGridView(
                      //   itemCount: 120,
                      //   crossAxisCount: 3,
                      //   crossAxisSpacing: 10,
                      //   mainAxisSpacing: 10,
                      //   builder: (ctx, index) {
                      //
                      //     return Container(
                      //       margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      //       height: 100,
                      //       width: 50,
                      //       color: Colors.yellow,
                      //     );
                      //   },
                      // ),
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
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Fetch the user data (followers and following counts)
    DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$userId');
    final DataSnapshot userSnapshot = await userRef.get();

    int followersCount = 0;
    int followingCount = 0;

    if (userSnapshot.exists) {
      followersCount = (userSnapshot.child('followers').value as Map<dynamic, dynamic>?)?.length ?? 0;
      followingCount = (userSnapshot.child('following').value as Map<dynamic, dynamic>?)?.length ?? 0;
    }

    // Fetch the post count from the 'posts' node
    DatabaseReference postsRef = FirebaseDatabase.instance.ref('posts/$userId');
    final DataSnapshot postsSnapshot = await postsRef.get();
    int postCount = postsSnapshot.exists ? (postsSnapshot.value as Map<dynamic, dynamic>).length : 0;

    // Return the map with counts
    return {
      'posts': postCount,
      'followers': followersCount,
      'following': followingCount,
    };
  }


// Future<Map<String, int>> fetchUserCounts() async {
  //   // Same as your existing method
  //   final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  //   DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$userId');
  //   final DataSnapshot snapshot = await userRef.get();
  //
  //   if (snapshot.exists) {
  //     int postCount = (snapshot.child('posts').value as Map<dynamic, dynamic>?)?.length ?? 0;
  //     int followersCount = (snapshot.child('followers').value as Map<dynamic, dynamic>?)?.length ?? 0;
  //     int followingCount = (snapshot.child('following').value as Map<dynamic, dynamic>?)?.length ?? 0;
  //
  //     return {
  //       'posts': postCount,
  //       'followers': followersCount,
  //       'following': followingCount,
  //     };
  //   } else {
  //     return {
  //       'posts': 0,
  //       'followers': 0,
  //       'following': 0,
  //     };
  //   }
  // }
}
