
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppImagePaths.dart';
import '../../controller/PostController.dart';
import '../../models/Post.dart';


class SocialScreen extends StatefulWidget {
   SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final PostController postController = Get.put(PostController());


  @override
  void initState() {
    super.initState();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    postController.fetchPostsFromFollowingUsers(userId);  // Fetch followed users' posts
    postController.fetchPosts();  // Fetch general posts
  }






  @override
  Widget build(BuildContext context) {

    postController.fetchPosts();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    postController.fetchFollowingUsersCount(userId);



    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Social Screen'), // Optional: Title of the AppBar
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Friends'),
              Tab(text: 'Foryou'),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                // Image with 0% corner radius (square or rectangular)
                const SizedBox(height: 10),
                // Optional: space between the image and the tabs
                // TabBarView for the content of the tabs
                Expanded(
                  child: TabBarView(

                    children: [
                      // Friends Tab Content

                      Obx(() {
                        return ListView.builder(
                          itemCount: postController.postsFollowing.length,
                          itemBuilder: (context, index) {
                            final post = postController.postsFollowing[index];
                            return PostCard1(post: post);
                          },
                        );
                      }),
                      // For you Tab Content (Other posts, e.g., random or trending posts)
                      Obx(() {
                        return ListView.builder(
                          itemCount: postController.posts.length,
                          itemBuilder: (context, index) {
                            final post = postController.posts[index];
                            return PostCard1(post: post);
                          },
                        );
                      }),

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
}
class PostCard1 extends StatelessWidget {
  final Post post;

  const PostCard1({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: AppColor.postBackColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          // Image Slider with loading indicator
          post.images.isNotEmpty
              ? Container(
            width: double.infinity,
            height: 250, // Adjust the height for the image slider
            child: PageView.builder(
              itemCount: post.images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  post.images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  // Loading Indicator
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Image is fully loaded
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    // Error placeholder
                    return Container(
                      color: Colors.grey,
                      child: const Icon(Icons.error, color: Colors.red),
                    );
                  },
                );
              },
            ),
          )
              : Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
              color: AppColor.error, // Placeholder color if no images
            ),
          ),
          const SizedBox(height: 12),
          // Post Content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.content,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          // Timestamp
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _formatDate(post.timestamp), // Format the date as needed
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 12),
              // Like button
              GestureDetector(
                onTap: () {
                  // Add action for like
                },
                child: Image.asset(
                  AppImagePaths.heart,
                  width: 26,
                  height: 26,
                ),
              ),
              const SizedBox(width: 8),
              // Comment button
              GestureDetector(
                onTap: () {
                  _showCommentBottomSheet(context);
                },
                child: Image.asset(
                  AppImagePaths.icon, // Replace with comment icon path
                  width: 24,
                  height: 25,
                ),
              ),
              const SizedBox(width: 8),
              // Share button
              GestureDetector(
                onTap: () {
                  // Add action for share
                },
                child: Image.asset(
                  AppImagePaths.send1, // Replace with share icon path
                  width: 26,
                  height: 26,
                ),
              ),
              const Spacer(),
              // Bookmark button
              GestureDetector(
                onTap: () {
                  // Add action for bookmark
                },
                child: Image.asset(
                  AppImagePaths.bookmark,
                  width: 26,
                  height: 26,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  void _showCommentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows us to control the height of the bottom sheet
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8, // 80% of the screen height
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add a Comment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your comment here...',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add your comment submission logic here
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}


// class PostCard1 extends StatelessWidget {
//   final Post post;
//
//   const PostCard1({required this.post});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       color: AppColor.postBackColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // User Name
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               post.userName,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//           ),
//           // Image Slider with loading indicator
//           post.images.isNotEmpty
//               ? Container(
//             width: double.infinity,
//             height: 250, // Adjust the height for the image slider
//             child: PageView.builder(
//               itemCount: post.images.length,
//               itemBuilder: (context, index) {
//                 return Image.network(
//                   post.images[index],
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   // Loading Indicator
//                   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                     if (loadingProgress == null) {
//                       return child; // Image is fully loaded
//                     } else {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           value: loadingProgress.expectedTotalBytes != null
//                               ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
//                               : null,
//                         ),
//                       );
//                     }
//                   },
//                   errorBuilder: (context, error, stackTrace) {
//                     // Error placeholder
//                     return Container(
//                       color: Colors.grey,
//                       child: const Icon(Icons.error, color: Colors.red),
//                     );
//                   },
//                 );
//               },
//             ),
//           )
//               : Container(
//             width: double.infinity,
//             height: 250,
//             decoration: const BoxDecoration(
//               color: AppColor.error, // Placeholder color if no images
//             ),
//           ),
//           const SizedBox(height: 12),
//           // Post Content
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               post.content,
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//           // Timestamp
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               _formatDate(post.timestamp), // Format the date as needed
//               style: const TextStyle(color: Colors.grey, fontSize: 12),
//             ),
//           ),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const SizedBox(width: 12),
//               // Like button
//               GestureDetector(
//                 onTap: () {
//                   // Add action for like
//                 },
//                 child: Image.asset(
//                   AppImagePaths.heart,
//                   width: 26,
//                   height: 26,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               // Comment button
//               GestureDetector(
//                 onTap: () {
//                   // Add action for comment
//                 },
//                 child: Image.asset(
//                   AppImagePaths.icon, // Replace with comment icon path
//                   width: 24,
//                   height: 25,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               // Share button
//               GestureDetector(
//                 onTap: () {
//                   // Add action for share
//                 },
//                 child: Image.asset(
//                   AppImagePaths.send1, // Replace with share icon path
//                   width: 26,
//                   height: 26,
//                 ),
//               ),
//               const Spacer(),
//               // Bookmark button
//               GestureDetector(
//                 onTap: () {
//                   // Add action for bookmark
//                 },
//                 child: Image.asset(
//                   AppImagePaths.bookmark,
//                   width: 26,
//                   height: 26,
//                 ),
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }
// }
String _formatDate(DateTime timestamp) {
  return DateFormat('dd MMM yyyy').format(timestamp); // Example: 16 Oct 2024
}
