
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness/screens/home/controller/AddPostController.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../../common/widgets/CircularImage.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import '../../models/Post.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddPostController addPostController = Get.put(AddPostController());
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: dark ? AppColor.white : AppColor.black,
          ),
        ),
        title: SimpleTextWidget(
          align: TextAlign.center,
          text: 'Create post',
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: dark ? AppColor.white : AppColor.black,
          fontFamily: 'Poppins',
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              // Check if there are selected images or text in the input field
              String inputText = addPostController.inputText.value;
              List<String> images = [
                if (addPostController.captureImagePath.isNotEmpty)
                  addPostController.captureImagePath.value,
                ...addPostController.selectedImages
              ].toSet().toList(); // Ensure unique images

              if (images.isEmpty && inputText.isEmpty) {
                print("No images or text provided.");
              } else {
                var uuid = const Uuid();
                String uniqueId = uuid.v4();
                String userId = FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID
                String userName = addPostController.userName.value; // Get the username
                String userProfilePic = addPostController.userProfilePic.value; // Get profile picture URL

                // Show a progress indicator while uploading images
                Get.dialog(const Center(child: CircularProgressIndicator()));

                // Upload images and get their URLs
                List<String> imageUrls = await uploadImages(images);

                // Create a new Post instance
                Post newPost = Post(
                  id: uniqueId, // Leave this empty, it will be generated
                  userId: userId,
                  userName: userName,
                  userProfilePic: userProfilePic,
                  content: inputText,
                  images: imageUrls,
                  timestamp: DateTime.now(),
                );

                // Save the post to Firebase Realtime Database
                 savePost(newPost);

                // Close the progress indicator
                Get.back(); // Close the loading dialog

                print('Post created: ${newPost.toMap()}');
                // Navigate to the dashboard or the desired screen
                Get.back(); // Example to go back after posting
              }
            },
            child: Container(
              height: 39,
              width: 80,
              decoration: BoxDecoration(
                color: AppColor.orangeLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: SimpleTextWidget(
                  text: 'Next',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          )
,
          const SizedBox(width: 8,)

        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => IconButton(
            onPressed: () async {
              if (addPostController.selectedImages.isEmpty) {
                addPostController.toggleCameraIconColor();
                await addPostController.openCamera();
              }
            },
            icon: Icon(
              Icons.camera_alt,
              color: addPostController.cameraIconColor.value,
            ),
          )),
          Obx(() => IconButton(
            onPressed: addPostController.captureImagePath.isNotEmpty ? null : () async {
              addPostController.togglePhotoIconColor();
              await addPostController.pickImage(isMultiple: true); // Allow multiple image selection
            },
            icon: Icon(
              Icons.photo,
              color: addPostController.photoIconColor.value,
            ),
          )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              // User Profile and Input Section
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      return CircularImage(
                        imageUrl: addPostController.userProfilePic.value.isNotEmpty
                            ? addPostController.userProfilePic.value
                            : AppImagePaths.placeholder1,
                        size: 58,
                      );
                    }),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Obx(() {
                          return SimpleTextWidget(
                            text: addPostController.userName.value.isNotEmpty
                                ? addPostController.userName.value
                                : 'Unnamed',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          );
                        }),
                        Container(
                          height: 23,
                          width: 100,
                          padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            color: AppColor.orangeLight.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Image.asset(
                                  height: 16,
                                  width: 16,
                                  AppImagePaths.send12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Text Input Field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.transparent),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    maxHeight: 150,
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: TextField(
                        minLines: 1,
                        maxLines: 7,
                        decoration: const InputDecoration(
                          hintText: "What’s on your mind?",
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          addPostController.inputText.value = text; // Update input text in controller
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Image Selection Grid
              Obx(() {
                final images = [
                  if (addPostController.captureImagePath.isNotEmpty)
                    addPostController.captureImagePath.value,
                  ...addPostController.selectedImages
                ].toSet().toList(); // Ensure unique images

                if (images.isNotEmpty) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: images.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(File(images[index])),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                addPostController.removeImage(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.withOpacity(0.7),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  void savePost(Post post) async {
    final DatabaseReference postRef = FirebaseDatabase.instance.ref().child('posts/${post.userId}').child(post.id);

    // Save post data to Realtime Database
    await postRef.set(post.toMap());
    print('Post saved to Realtime Database!');
  }

  Future<List<String>> uploadImages(List<String> imagePaths) async {
    List<String> imageUrls = [];

    for (String imagePath in imagePaths) {
      File file = File(imagePath);
      try {
        // Create a reference to the Firebase Storage location
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg'; // Unique filename
        Reference storageRef = FirebaseStorage.instance.ref().child('posts/$fileName');

        // Upload the file
        TaskSnapshot uploadTask = await storageRef.putFile(file);

        // Get the download URL
        String downloadUrl = await uploadTask.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    return imageUrls;
  }


}
