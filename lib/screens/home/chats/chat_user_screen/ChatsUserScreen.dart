import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/home/chats/chat_detail_screen/ChatDetailScreen.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../search_screen/widgets/UserCard1.dart';

class ChatsUserScreen extends StatefulWidget {
  const ChatsUserScreen({super.key});

  @override
  _ChatsUserScreenState createState() => _ChatsUserScreenState();
}

class _ChatsUserScreenState extends State<ChatsUserScreen> {
  List<Map<String, dynamic>> followingUsersList = []; // List to hold followed users data
  bool isLoadingFollowing = true;
  final String placeholderImageUrl = 'https://ttwo.dk/person-placeholder/'; // Placeholder image URL

  @override
  void initState() {
    super.initState();
    fetchFollowedUsers(); // Fetch the followed users on init
  }

  Future<void> fetchFollowedUsers() async {
    final User? currentUser = FirebaseAuth.instance.currentUser; // Get current logged-in user
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
          print('Followed users found: $followingUsersList');
        }

        setState(() {
          isLoadingFollowing = false; // Set loading state to false after fetching
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
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);


        }, icon: Icon(Icons.arrow_back ,color:  dark ? AppColor.white : AppColor.black,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: isLoadingFollowing
            ? const Center(child: CircularProgressIndicator()) // Show loader while fetching
            : followingUsersList.isEmpty
            ? const Center(child: Text("No followed users found."))
            : ListView.builder(
          itemCount: followingUsersList.length,
          itemBuilder: (context, index) {
            final user = followingUsersList[index];

            return UserCard1(
              dark: dark,
              userName: user['name'],
              userID: user['id'],
              userImageUrl: user['imageUrl'],
              onMessage: () {
                print('click');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ChatDetailScreen(userID: user['id'], userName:  user['name'],)),
                );
              },
            );

            // return UserCard1(
            //   dark: dark,
            //   userName: user['name'],
            //   userImageUrl: user['imageUrl'],
            //   onMessage: () {
            //     print('clicl');
            //     Navigator.push(context,               MaterialPageRoute(builder: (context) => const ChatDetailScreen()),
            //     );
            //     // Add action for messaging
            //   },
            // );
          },
        ),
      ),
    );
  }
}
