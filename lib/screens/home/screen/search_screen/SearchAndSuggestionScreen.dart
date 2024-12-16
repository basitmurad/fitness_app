import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/home/screen/search_screen/widgets/UserCard.dart';
import 'package:fitness/screens/home/screen/search_screen/widgets/UserCard1.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../exercise_screen/screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import '../chats_screen/chat_detail_screen/ChatDetailScreen.dart';

class SearchAndSuggestionScreen extends StatefulWidget {
  const SearchAndSuggestionScreen({super.key});

  @override
  _SearchAndSuggestionScreenState createState() =>
      _SearchAndSuggestionScreenState();
}

class _SearchAndSuggestionScreenState extends State<SearchAndSuggestionScreen> {
  List<Map<String, dynamic>> usersList = [];
  List<Map<String, dynamic>> filteredUsersList = [];
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> followingUsersList = [];
  bool isLoadingFollowing = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFollowedUsers();
    fetchUsers();
    searchController.addListener(() {
      filterUsers();
    });
  }

  Future<void> fetchUsers() async {
    final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
      return;
    }

    setState(() {
      isLoading = true;
    });

    usersRef.onValue.listen((DatabaseEvent event) {
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        final Map<dynamic, dynamic> usersMap = dataSnapshot.value as Map<dynamic, dynamic>;
        usersList.clear();

        usersMap.forEach((key, value) {
          final userId = key;
          final userName = value['name'] ?? 'Unknown';
          final userImageUrl = value['imageUrl'] ?? AppImagePaths.placeholder;

          if (userId != currentUser.uid && !_isUserFollowed(userId)) {
            usersList.add({
              'id': userId,
              'name': userName,
              'imageUrl': userImageUrl,
            });
          }
        });

        filteredUsersList = List.from(usersList);
        setState(() {});
      } else {
        if (kDebugMode) {
          print('No users found.');
        }
      }

      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      if (kDebugMode) {
        print('Error fetching users: $error');
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  bool _isUserFollowed(String userId) {
    return followingUsersList.any((user) => user['id'] == userId);
  }

  void onRemove(String userId) {
    setState(() {
      usersList.removeWhere((user) => user['id'] == userId);
      filteredUsersList.removeWhere((user) => user['id'] == userId);
    });
  }

  void onFollow(String followedUserId, String followedUserName, String imageUrl) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

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
      await currentUserRef.set({
        'id': followedUserId,
        'name': followedUserName,
        'imageUrl': imageUrl,
      });

      await followedUserRef.set({
        'id': currentUser.uid,
        'name': currentUser.displayName ?? 'Unknown',
        'imageUrl': currentUser.photoURL ?? AppImagePaths.placeholder,
      });

      if (kDebugMode) {
        print("Followed user $followedUserName and updated their followers list.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error following user: $e");
      }
    }
  }

  void filterUsers() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredUsersList = usersList.where((user) {
        final userName = user['name']?.toLowerCase() ?? '';
        return userName.contains(query);
      }).toList();
    });
  }

  Future<void> fetchFollowedUsers() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      if (kDebugMode) {
        print("User not logged in.");
      }
      return;
    }

    final DatabaseReference followingRef = FirebaseDatabase.instance.ref('users/${currentUser.uid}/following');

    setState(() {
      isLoadingFollowing = true;
    });

    followingRef.onValue.listen((DatabaseEvent event) {
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        final Map<dynamic, dynamic> followingMap = dataSnapshot.value as Map<dynamic, dynamic>;
        followingUsersList.clear();

        followingMap.forEach((key, value) {
          final followedUserId = key;
          final followedUserName = value['name'] ?? 'Unknown';
          final followedUserImageUrl = value['imageUrl'] ?? AppImagePaths.placeholder;

          followingUsersList.add({
            'id': followedUserId,
            'name': followedUserName,
            'imageUrl': followedUserImageUrl,
          });
        });

        setState(() {
          isLoadingFollowing = false;
        });
      } else {
        setState(() {
          isLoadingFollowing = false;
        });
      }
    }, onError: (error) {
      if (kDebugMode) {
        print('Error fetching followed users: $error');
      }
      setState(() {
        isLoadingFollowing = false;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 2,
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
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: Icon(Icons.search),
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
                  ListView.builder(
                    itemCount: filteredUsersList.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsersList[index];
                      return UserCard(
                        dark: dark,
                        userName: user['name'] ?? 'Unknown',
                        userImageUrl: user['imageUrl'] ?? AppImagePaths.placeholder,
                        onRemove: () => onRemove(user['id']),
                        onFollow: () => onFollow(
                          user['id'],
                          user['name'] ?? 'Unknown',
                          user['imageUrl'] ?? AppImagePaths.placeholder,
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: followingUsersList.length,
                    itemBuilder: (context, index) {
                      final user = followingUsersList[index];
                      return UserCard1(
                        dark: dark,
                        userID: user['id'],
                        userName: user['name'] ?? 'Unknown',
                        userImageUrl: user['imageUrl'] ?? AppImagePaths.placeholder,
                        onMessage: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailScreen(
                                userID: user['id'],
                                userName: user['name'] ?? 'Unknown',
                              ),
                            ),
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
