import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../modelClass/Post.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var postsFollowing = <Post>[].obs;
  var followedUsers = <User>[].obs;
  var followedUserIds = <String>[].obs; // List to hold followed user IDs



  // Fetch the following users and return the count of followed users
  Future<int> fetchFollowingUsersCount(String userId) async {
    final DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$userId/following');
    DataSnapshot snapshot = await userRef.get();
    if (snapshot.exists) {
      final followingList = snapshot.value as Map<dynamic, dynamic>?;
      followedUsers.clear(); // Clear the list before fetching new data
      followedUserIds.clear(); // Clear the followed user IDs list

      if (followingList != null) {
        for (var followedUserId in followingList.keys) {
          followedUserIds.add(followedUserId);
          print('following user are $followedUserId');// Only store the user IDs
        }
      }

      return followedUserIds.length; // Return the count of followed users
    }

    return 0; // Return 0 if there are no followed users
  }
  // Fetch posts from Firebase
  Future<void> fetchPosts() async {
    final DatabaseReference postsRef = FirebaseDatabase.instance.ref('posts');
    postsRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      posts.clear();
      if (data != null) {
        List<Post> tempPosts = [];
        data.forEach((userId, userPosts) {
          if (userPosts is Map<dynamic, dynamic>) {
            userPosts.forEach((postId, postData) {
              Post post = Post.fromMap(Map<String, dynamic>.from(postData));
              tempPosts.add(post);
            });
          }
        });
        posts.assignAll(tempPosts.reversed.toList());
      }
    });
  }

  Future<void> fetchPostsFromFollowingUsers(String currentUserId) async {
    await fetchFollowingUsers(currentUserId);
    final DatabaseReference postsRef = FirebaseDatabase.instance.ref('posts');
    postsRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      postsFollowing.clear();
      if (data != null) {
        List<Post> tempPosts = [];
        data.forEach((userId, userPosts) {
          if (followedUserIds.contains(userId)) {
            if (userPosts is Map<dynamic, dynamic>) {
              userPosts.forEach((postId, postData) {
                Post post = Post.fromMap(Map<String, dynamic>.from(postData));
                tempPosts.add(post);
              });
            }
          }
        });
        postsFollowing.assignAll(tempPosts.reversed.toList());
      }
    });
  }

  // Fetch the following users and return the count of followed users
  Future<int> fetchFollowingUsers(String userId) async {
    final DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$userId/following');
    DataSnapshot snapshot = await userRef.get();
    if (snapshot.exists) {
      final followingList = snapshot.value as Map<dynamic, dynamic>?;
      followedUserIds.clear(); // Clear the followed user IDs list

      if (followingList != null) {
        for (var followedUserId in followingList.keys) {
          followedUserIds.add(followedUserId); // Only store the user IDs
        }
      }

      return followedUserIds.length; // Return the count of followed users
    }

    return 0; // Return 0 if there are no followed users
  }
}

class User {
  String id;
  String name;
  String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  // Create User from Firebase data
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}


