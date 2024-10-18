import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/widgets/ButtonWidget.dart';
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
class PostCard1 extends StatefulWidget {
  final Post post;

  const PostCard1({super.key, required this.post});

  @override
  State<PostCard1> createState() => _PostCard1State();
}

class _PostCard1State extends State<PostCard1> {
  final TextEditingController _commentController = TextEditingController();
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('Comments');
  final DatabaseReference likesRef = FirebaseDatabase.instance.ref('Likes'); // Reference for likes

  // List to hold fetched comments
  List<Map<String, dynamic>> comments = [];

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
              widget.post.userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          // Image Slider with loading indicator
          widget.post.images.isNotEmpty
              ? SizedBox(
            width: double.infinity,
            height: 250,
            child: PageView.builder(
              itemCount: widget.post.images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.post.images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Image is fully loaded
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
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
              widget.post.content,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          // Timestamp
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _formatDate(widget.post.timestamp),
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
                  _toggleLike();  // Toggle like status

                  // setState(() {
                  //   widget.post.toggleLike();
                  // });
                },
                child: Icon(
                  widget.post.isLiked
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  size: 26,
                  color:
                  widget.post.isLiked ? AppColor.orangeColor : null,
                ),
              ),
              const SizedBox(width: 8),
              // Comment button
              GestureDetector(
                onTap: () {
                  _showCommentBottomSheet(context);
                },
                child: Image.asset(
                  AppImagePaths.icon,
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
                  AppImagePaths.send1,
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

  bool _isLoading = false; // Loading state
  void _showCommentBottomSheet(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    // Show loading state before fetching comments
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        // Ensure _fetchComments is called after bottom sheet is rendered
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _isLoading = true;
          });
          _fetchComments();
        });

        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add a Comment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your comment here...',
                ),
              ),
              const SizedBox(height: 16),

              // Display loading or fetched comments
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : comments.isEmpty
                    ? const Center(child: Text('No comments available.'))
                    : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      title: Text(comment['comment']),
                      subtitle: Text(
                        _formatDate(DateTime.fromMillisecondsSinceEpoch(comment['timestamp'])),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MyAppHelperFunctions.screenWidth(),
                child: ButtonWidget(
                  dark: dark,
                  onPressed: () {
                    _uploadComment(); // Call upload comment function
                  },
                  buttonText: 'Comment',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
// Toggle like status
  void _toggleLike() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String postId = widget.post.id;

    setState(() {
      widget.post.isLiked = !widget.post.isLiked;
    });

    if (widget.post.isLiked) {
      // User likes the post, update Firebase
      likesRef.child(postId).child(userId).set(true).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Liked the post!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to like the post: $error')),
        );
      });
    } else {
      // User unlikes the post, update Firebase
      likesRef.child(postId).child(userId).remove().then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unliked the post!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to unlike the post: $error')),
        );
      });
    }
  }

// Fetch comments from Firebase
  void _fetchComments() {
    String postId = widget.post.id;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Fetch comments for the specific post
    databaseReference.child(userId).child(postId).once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        // Clear previous comments
        comments.clear();

        // Iterate through each comment in the snapshot
        Map<dynamic, dynamic> commentData = event.snapshot.value as Map<dynamic, dynamic>;
        commentData.forEach((key, value) {
          comments.add({
            'comment': value['comment'],
            'userId': value['userId'],
            'timestamp': value['timestamp'],
          });
        });
      } else {
        // Handle case where there are no comments
        comments.clear();
      }

      // Set loading to false and refresh UI after fetching comments
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      // Handle error during fetch
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load comments: $error')),
      );

      // Set loading to false and refresh UI
      setState(() {
        _isLoading = false;
      });
    });
  }


  void _uploadComment() {
    final String commentText = _commentController.text.trim();
    if (commentText.isNotEmpty) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String postId = widget.post.id;

      // Define the comment data
      Map<String, dynamic> commentData = {
        'comment': commentText,
        'userId': userId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      // Upload the comment to Firebase using push to generate a unique key
      databaseReference.child(userId).child(postId).push().set(commentData).then((_) {
        _commentController.clear(); // Clear the input
        Navigator.pop(context); // Close the bottom sheet
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment added successfully!')),
        );
        _fetchComments(); // Fetch comments again to update the list
      }).catchError((error) {
        // Handle error during upload
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add comment: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a comment.')),
      );
    }
  }
}




String _formatDate(DateTime timestamp) {
  return DateFormat('dd MMM yyyy').format(timestamp); // Example: 16 Oct 2024
}
