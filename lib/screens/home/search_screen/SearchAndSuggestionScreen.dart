import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/home/search_screen/widgets/UserCard.dart';
import 'package:fitness/screens/home/search_screen/widgets/UserCard1.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../exercise_screen/screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import '../chats/chat_detail_screen/ChatDetailScreen.dart';

class SearchAndSuggestionScreen extends StatefulWidget {
  const SearchAndSuggestionScreen({super.key});

  @override
  _SearchAndSuggestionScreenState createState() =>
      _SearchAndSuggestionScreenState();
}

class _SearchAndSuggestionScreenState extends State<SearchAndSuggestionScreen> {
  List<Map<String, dynamic>> usersList = []; // List to hold user data
  List<Map<String, dynamic>> filteredUsersList =
      []; // List to hold filtered user data
  TextEditingController searchController =
      TextEditingController(); // Controller for the search field
  final String placeholderImageUrl =
      'https://ttwo.dk/person-placeholder/'; // Placeholder image URL
  List<Map<String, dynamic>> followingUsersList =
      []; // List to hold followed users data
  bool isLoadingFollowing = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFollowedUsers(); // Fetch the followed users

    fetchUsers(); // Fetch users when the widget is initialized
    // Listen for changes in the search field
    searchController.addListener(() {
      filterUsers();
    });
  }

  // Fetch users from the database
  Future<void> fetchUsers() async {
    final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users'); // Reference to the 'users' node
    final User? currentUser = FirebaseAuth.instance.currentUser; // Get the current logged-in user

    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
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

          // Check if the user is not the current user and not followed
          if (userId != currentUser.uid && !_isUserFollowed(userId)) {
            usersList.add({
              'id': userId,
              'name': userName,
              'imageUrl': userImageUrl, // Include image URL
            });
          }
        });

        // Initialize filtered list with all users (filtered for those not followed)
        filteredUsersList = List.from(usersList);
        if (kDebugMode) {
          print('Users List: $usersList');
          print('Filtered Users List: $filteredUsersList');
        }
        setState(() {}); // Update the UI after fetching
      } else {
        if (kDebugMode) {
          print('No users found.');
        }
      }

      setState(() {
        isLoading = false; // Set loading state to false after fetching
      });
    }, onError: (error) {
      if (kDebugMode) {
        print('Error fetching users: $error');
      }
      setState(() {
        isLoading = false; // Set loading state to false after fetching
      });
    });
  }

// Helper method to check if a user is already followed
  bool _isUserFollowed(String userId) {
    bool isFollowed = followingUsersList.any((user) => user['id'] == userId);
    if (kDebugMode) {
      print('Checking if user $userId is followed: $isFollowed');
    }
    return isFollowed;
  }





  void onRemove(String userId) {
    setState(() {
      usersList.removeWhere((user) => user['id'] == userId);
      filteredUsersList.removeWhere((user) => user['id'] == userId);
    });
  }

  void onFollow(
      String followedUserId, String followedUserName, String imageUrl) async {
    final User? currentUser =
        FirebaseAuth.instance.currentUser; // Get current logged-in user
    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
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
        'imageUrl': imageUrl,
      });

      // Update the followed user's "followers" node with the current user's info
      await followedUserRef.set({
        'id': currentUser.uid,
        'name': currentUser.displayName ?? 'Unknown',
        'imageUrl': imageUrl,
// Use displayName if available
      });

      if (kDebugMode) {
        print(
          "Followed user $followedUserName and updated their followers list.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error following user: $e");
      }
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



  Future<void> fetchFollowedUsers() async {
    final User? currentUser =
        FirebaseAuth.instance.currentUser; // Get current logged-in user
    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
      return;
    }

    final DatabaseReference followingRef = FirebaseDatabase.instance.ref(
        'users/${currentUser.uid}/following'); // Reference to current user's 'following' node

    setState(() {
      isLoadingFollowing = true; // Set loading state to true before fetching
    });

    // Listen for value changes at the 'following' node
    followingRef.onValue.listen((DatabaseEvent event) {
      final dataSnapshot = event.snapshot;

      // Check if data is available
      if (dataSnapshot.exists) {
        // Convert the data to a Map
        final Map<dynamic, dynamic> followingMap =
        dataSnapshot.value as Map<dynamic, dynamic>;

        // Clear previous data
        followingUsersList.clear();

        // Iterate through each followed user in the map
        followingMap.forEach((key, value) {
          // key is the followed user ID
          // value contains the followed user data (e.g., name, imageUrl)
          final followedUserId = key;
          final followedUserName = value['name'];
          final followedUserImageUrl = value['imageUrl'] ?? placeholderImageUrl;

          // Add followed user data to the list
          followingUsersList.add({
            'id': followedUserId,
            'name': followedUserName,
            'imageUrl': followedUserImageUrl,
          });
        });

        if (kDebugMode) {
          print(' followed users found. $followingUsersList');
        }

        setState(() {
          isLoadingFollowing =
          false; // Set loading state to false after fetching
        });
      } else {
        if (kDebugMode) {
          print('No followed users found.');
        }
        setState(() {
          isLoadingFollowing = false; // Set loading state to false
        });
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('Error fetching followed users: $error');
      }
      setState(() {
        isLoadingFollowing = false; // Set loading state to false
      });
    });
  }


  @override
  void dispose() {
    searchController
        .dispose(); // Dispose the controller when the widget is removed
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
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context); // Navigate back
          //   },
          //   icon: Icon(
          //     CupertinoIcons.arrow_left,
          //     color: dark ? AppColor.white : AppColor.black,
          //   ),
          // ),
        ),
        body: Column(
          children: [
            // Search field outside of the TabBar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: Icon(Icons.search), // Search icon
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TabBar(
              indicatorColor: AppColor.orangeColor,
              labelColor: dark ? AppColor.white : AppColor.dark,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Suggested'),
                Tab(text: 'Friends'),
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
                        userImageUrl: user['imageUrl'],
                        // Pass the image URL to UserCard

                        onRemove: () => onRemove(user['id']),
                        onFollow: () => onFollow(
                            user['id'],
                            user['name'],
                            user[
                                'imageUrl']), // Pass the userId and userName here

                        // Pass the user name
                      );
                    },
                  ),
                  // Suggested Tab (can be implemented similarly)
                  ListView.builder(
                    itemCount: followingUsersList.length,
                    itemBuilder: (context, index) {
                      final user = followingUsersList[index];

                      return UserCard1(
                        dark: dark,
                        userID: user['id'],

                        userName: user['name'],
                        userImageUrl: user['imageUrl'],
                        onMessage: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  ChatDetailScreen(userID: user['id'], userName: user['name'],)),
                          );


                        },
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


