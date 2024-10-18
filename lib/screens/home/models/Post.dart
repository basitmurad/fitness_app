// //
// // class Post {
// //   String id; // Unique identifier for the post
// //   String userId; // ID of the user who created the post
// //   String userName; // Name of the user
// //   String userProfilePic; // User's profile picture URL
// //   String content; // Text content of the post
// //   List<String> images; // List of image file paths
// //   DateTime timestamp; // Time the post was created
// //
// //   // Constructor
// //   Post({
// //     required this.id,
// //     required this.userId,
// //     required this.userName,
// //     required this.userProfilePic,
// //     required this.content,
// //     required this.images,
// //     required this.timestamp,
// //   });
// //
// //   // Method to convert the Post object to a map (for saving to a database)
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'id': id,
// //       'userId': userId,
// //       'userName': userName,
// //       'userProfilePic': userProfilePic,
// //       'content': content,
// //       'images': images,
// //       'timestamp': timestamp.toIso8601String(),
// //     };
// //   }
// //
// //   // Factory constructor to create a Post from a map (for reading from a database)
// //   factory Post.fromMap(Map<String, dynamic> map) {
// //     return Post(
// //       id: map['id'] ?? '', // Default to an empty string if null
// //       userId: map['userId'] ?? '', // Default to an empty string if null
// //       userName: map['userName'] ?? 'Unknown', // Default to 'Unknown' if null
// //       userProfilePic: map['userProfilePic'] ?? '', // Default to an empty string if null
// //       content: map['content'] ?? '', // Default to an empty string if null
// //       images: List<String>.from(map['images'] ?? []), // Default to an empty list if null
// //       timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()), // Default to current time if null
// //     );
// //   }
// //
// //   @override
// //   String toString() {
// //     return 'Post(id: $id, content: $content, userName: $userName, timestamp: $timestamp, images: $images)';
// //   }
// // }
// class Post {
//   String id; // Unique identifier for the post
//   String userId; // ID of the user who created the post
//   String userName; // Name of the user
//   String userProfilePic; // User's profile picture URL
//   String content; // Text content of the post
//   List<String> images; // List of image file paths
//   DateTime timestamp; // Time the post was created
//   int likes; // Number of likes
//
//   // Constructor
//   Post({
//     required this.id,
//     required this.userId,
//     required this.userName,
//     required this.userProfilePic,
//     required this.content,
//     required this.images,
//     required this.timestamp,
//     this.likes = 0, // Initialize likes to 0
//   });
//
//   // Method to convert the Post object to a map (for saving to a database)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userId': userId,
//       'userName': userName,
//       'userProfilePic': userProfilePic,
//       'content': content,
//       'images': images,
//       'timestamp': timestamp.toIso8601String(),
//       'likes': likes, // Include likes in the map
//     };
//   }
//
//   // Factory constructor to create a Post from a map (for reading from a database)
//   factory Post.fromMap(Map<String, dynamic> map) {
//     return Post(
//       id: map['id'] ?? '', // Default to an empty string if null
//       userId: map['userId'] ?? '', // Default to an empty string if null
//       userName: map['userName'] ?? 'Unknown', // Default to 'Unknown' if null
//       userProfilePic: map['userProfilePic'] ?? '', // Default to an empty string if null
//       content: map['content'] ?? '', // Default to an empty string if null
//       images: List<String>.from(map['images'] ?? []), // Default to an empty list if null
//       timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()), // Default to current time if null
//       likes: map['likes'] ?? 0, // Default to 0 likes if null
//     );
//   }
//
//   @override
//   String toString() {
//     return 'Post(id: $id, content: $content, userName: $userName, timestamp: $timestamp, images: $images, likes: $likes)';
//   }
// }
class Post {
  String id; // Unique identifier for the post
  String userId; // ID of the user who created the post
  String userName; // Name of the user
  String userProfilePic; // User's profile picture URL
  String content; // Text content of the post
  List<String> images; // List of image file paths
  DateTime timestamp; // Time the post was created
  int likes; // Number of likes
  bool isLiked; // Track if the post is liked by the current user
  List<String> likedUsers; // List of user IDs that liked the post

  // Constructor
  Post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfilePic,
    required this.content,
    required this.images,
    required this.timestamp,
    this.likes = 0, // Initialize likes to 0
    this.isLiked = false,
    required this.likedUsers,
// Initialize isLiked to false
  });

  // Method to convert the Post object to a map (for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userProfilePic': userProfilePic,
      'content': content,
      'images': images,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes, // Include likes in the map
      'isLiked': isLiked, // Include isLiked in the map
    };
  }

  // Factory constructor to create a Post from a map (for reading from a database)
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '', // Default to an empty string if null
      userId: map['userId'] ?? '', // Default to an empty string if null
      userName: map['userName'] ?? 'Unknown', // Default to 'Unknown' if null
      userProfilePic: map['userProfilePic'] ?? '', // Default to an empty string if null
      content: map['content'] ?? '', // Default to an empty string if null
      images: List<String>.from(map['images'] ?? []), // Default to an empty list if null
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()), // Default to current time if null
      likes: map['likes'] ?? 0, // Default to 0 likes if null
      isLiked: map['isLiked'] ?? false, likedUsers: [], // Default to false if null
    );
  }

  // Method to toggle like state
  void toggleLike() {
    isLiked = !isLiked; // Toggle the isLiked state
    likes += isLiked ? 1 : -1; // Increase or decrease likes based on new state
  }

  bool isLiked2(String userId) {
    return likedUsers.contains(userId);
  }
  @override
  String toString() {
    return 'Post(id: $id, content: $content, userName: $userName, timestamp: $timestamp, images: $images, likes: $likes, isLiked: $isLiked)';
  }
}
