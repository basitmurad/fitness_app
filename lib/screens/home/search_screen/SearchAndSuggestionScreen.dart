import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/CircularImage.dart';

class SearchAndSuggestionScreen extends StatefulWidget {
  const SearchAndSuggestionScreen({super.key});

  @override
  _SearchAndSuggestionScreenState createState() => _SearchAndSuggestionScreenState();
}

class _SearchAndSuggestionScreenState extends State<SearchAndSuggestionScreen> {
  List<Map<String, dynamic>> usersList = []; // List to hold user data
  List<Map<String, dynamic>> filteredUsersList = []; // List to hold filtered user data
  TextEditingController searchController = TextEditingController(); // Controller for the search field
  final String placeholderImageUrl = 'https://ttwo.dk/person-placeholder/'; // Placeholder image URL

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Fetch users when the widget is initialized
    // Listen for changes in the search field
    searchController.addListener(() {
      filterUsers();
    });
  }
  Future<void> fetchUsers() async {
    final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users'); // Adjust the reference to your users node
    final User? currentUser = FirebaseAuth.instance.currentUser; // Get the current logged-in user
    if (currentUser == null) {
      print("User not logged in.");
      return;
    }
    setState(() {
      isLoading = true; // Set loading state to true before fetching
    });

    // Listen for value changes at the 'users' node
    usersRef.onValue.listen((DatabaseEvent event) {
      final dataSnapshot = event.snapshot;

      // Check if data is available
      if (dataSnapshot.exists) {
        // Convert the data to a Map
        final Map<dynamic, dynamic> usersMap = dataSnapshot.value as Map<dynamic, dynamic>;

        // Clear previous data
        usersList.clear();

        // Iterate through each user in the map
        usersMap.forEach((key, value) {
          // key is the user ID
          // value should contain user data (e.g., name)
          final userId = key;
          final userName = value['name']; // Adjust according to your data structure
          final userImageUrl = value['imageUrl'] ?? placeholderImageUrl; // Get image URL or use placeholder

          // Add user data to the list only if it's not the current user
          if (userId != currentUser.uid) {
            usersList.add({
              'id': userId,
              'name': userName,
              'imageUrl': userImageUrl, // Include image URL

            });
          }
        });

        // Initialize filtered list with all users
        filteredUsersList = List.from(usersList);
        setState(() {}); // Update the UI after fetching users
      } else {
        print('No users found.');
      }
      setState(() {
        isLoading = false; // Set loading state to false after fetching
      });
    }, onError: (error) {
      print('Error fetching users: $error');
      setState(() {
        isLoading = false; // Set loading state to false after fetching
      });
    });
  }


  // Future<void> fetchUsers() async {
  //   final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users'); // Adjust the reference to your users node
  //
  //   // Listen for value changes at the 'users' node
  //   usersRef.onValue.listen((DatabaseEvent event) {
  //     final dataSnapshot = event.snapshot;
  //
  //     // Check if data is available
  //     if (dataSnapshot.exists) {
  //       // Convert the data to a Map
  //       final Map<dynamic, dynamic> usersMap = dataSnapshot.value as Map<dynamic, dynamic>;
  //
  //       // Clear previous data
  //       usersList.clear();
  //
  //       // Iterate through each user in the map
  //       usersMap.forEach((key, value) {
  //         // key is the user ID
  //         // value should contain user data (e.g., name)
  //         final userId = key;
  //         final userName = value['name']; // Adjust according to your data structure
  //
  //         // Add user data to the list
  //         usersList.add({
  //           'id': userId,
  //           'name': userName,
  //         });
  //       });
  //
  //       // Initialize filtered list with all users
  //       filteredUsersList = List.from(usersList);
  //       setState(() {}); // Update the UI after fetching users
  //     } else {
  //       print('No users found.');
  //     }
  //   }, onError: (error) {
  //     print('Error fetching users: $error');
  //   });
  // }
  void onRemove(String userId) {
    setState(() {
      usersList.removeWhere((user) => user['id'] == userId);
      filteredUsersList.removeWhere((user) => user['id'] == userId);
    });
  }


  void onFollow(String followedUserId, String followedUserName) async {
    final User? currentUser = FirebaseAuth.instance.currentUser; // Get current logged-in user
    if (currentUser == null) {
      print("User not logged in.");
      return;
    }

    final DatabaseReference currentUserRef = FirebaseDatabase.instance
        .ref('users/${currentUser.uid}/following/$followedUserId');
    final DatabaseReference followedUserRef = FirebaseDatabase.instance
        .ref('users/$followedUserId/followers/${currentUser.uid}');

    try {
      // Update the current user's "following" node with the followed user's info
      await currentUserRef.set({
        'id': followedUserId,
        'name': followedUserName,
      });

      // Update the followed user's "followers" node with the current user's info
      await followedUserRef.set({
        'id': currentUser.uid,
        'name': currentUser.displayName ?? 'Unknown', // Use displayName if available
      });

      print("Followed user $followedUserName and updated their followers list.");
    } catch (e) {
      print("Error following user: $e");
    }
  }


  void filterUsers() {
    final query = searchController.text.toLowerCase();
    // Filter users based on the query
    setState(() {
      filteredUsersList = usersList.where((user) {
        final userName = user['name'].toLowerCase();
        return userName.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SimpleTextWidget(
            text: 'Add Friends',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins',
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back
            },
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: dark ? AppColor.white : AppColor.black,
            ),
          ),
        ),
        body: Column(
          children: [
            // Search field outside of the TabBar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: const Icon(Icons.search), // Search icon
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            TabBar(
              indicatorColor: AppColor.orangeColor,
              labelColor: dark ? AppColor.white : AppColor.dark,
              unselectedLabelColor: Colors.grey,
              tabs: [
                const Tab(text: 'Friends'),
                const Tab(text: 'Suggested'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Friends Tab
                  ListView.builder(
                    itemCount: filteredUsersList.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsersList[index];
                      return UserCard(
                        dark: dark,
                        userName: user['name'],
                        userImageUrl: user['imageUrl'], // Pass the image URL to UserCard

                        onRemove: () => onRemove(user['id']),
                        onFollow: () => onFollow(user['id'], user['name']), // Pass the userId and userName here

                        // Pass the user name
                      );
                    },
                  ),
                  // Suggested Tab (can be implemented similarly)
                  ListView.builder(
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return UserCard1(
                        dark: dark,
                        userName: 'basit ', // Pass the user name
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.dark,
    required this.userName,
    required this.onRemove, required this.onFollow, required this.userImageUrl, // Add onRemove parameter
  });

  final bool dark;
  final String userName;
  final String userImageUrl;
  final VoidCallback onRemove; // Callback to handle removal
  final VoidCallback onFollow; // Callback to handle removal

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      height: 120,
      width: AppDevicesUtils.screenWidth() * 1.2,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5),
          CircularImage(
            imageUrl: userImageUrl,
            size: 98,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              SimpleTextWidget(
                text: userName,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(height: 1),
              SimpleTextWidget(
                text: 'You may know “$userName”',
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 50,
                    width: 220,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 91,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.grey1.withOpacity(0.6),
                          ),
                          child: TextButton(
                            onPressed: onRemove, // Call the onRemove callback
                            child: SimpleTextWidget(
                              text: 'Remove',
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: dark ? AppColor.white : AppColor.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.orangeColor,
                          ),
                          child: TextButton(
                            onPressed: onFollow,
                            child: const SimpleTextWidget(
                              text: 'Follow',
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: AppColor.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserCard1 extends StatelessWidget {
  const UserCard1({
    super.key,
    required this.dark,
    required this.userName,
  });

  final bool dark;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4)),
      height: 120,
      width: AppDevicesUtils.screenWidth() * 1.2,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5), // Space between the image and the text

          CircularImage(
            imageUrl:
            'https://images.unsplash.com/photo-1727324358652-e82abf20aad2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            size: 98,
          ),
          const SizedBox(width: 10), // Space between the image and the text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5), // Space at the top
              SimpleTextWidget(
                text: 'userName',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(
                height: 1,
              ),
              SimpleTextWidget(
                text: 'You may know “Miachel”',
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 50,
                    width: 220,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 91,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.grey1.withOpacity(0.6),
                          ),
                          child: TextButton(
                              onPressed: () {},
                              child: SimpleTextWidget(
                                  text: 'Remove',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: dark ? AppColor.black : AppColor.black,
                                  fontFamily: 'Poppins')),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColor.orangeColor),
                          child: TextButton(
                              onPressed: () {},
                              child: const SimpleTextWidget(
                                  text: 'Follow',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: AppColor.white,
                                  fontFamily: 'Poppins')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

