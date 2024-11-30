import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/AppColor.dart';

class AddPostController extends GetxController {
  var cameraIconColor = AppColor.orangeLight.obs; // Observable color for the camera icon
  var photoIconColor = AppColor.orangeLight.obs; // Observable color for the photo icon
  var locationIconColor = AppColor.orangeLight.obs; // Observable color for the location icon
  var personIconColor = AppColor.orangeLight.obs;
  var postText = ''.obs; // Observable for post text
  var imageFileList = <XFile>[].obs; // Observable list of selected images
  var singleImagePath = ''.obs; // Observable for single image path
  final ImagePicker imagePicker = ImagePicker();
  var selectedImages = <String>[].obs; // List to store the paths of selected images
  Rx<String> inputText = ''.obs;
  var captureImagePath = ''.obs;
  var selectedImage = ''.obs; // Add this line

  var userName = ''.obs;
  var userProfilePic = ''.obs;// Observable color for the person icon
  RxBool isNextClicked = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserDetails(); // Fetch user details when controller initializes
  }


  Future<void> pickImage({bool isMultiple = false}) async {
    if (isMultiple) {
      // Select multiple images
      final List<XFile>? images = await imagePicker.pickMultiImage();
      if (images != null && images.isNotEmpty) {
        selectedImages.assignAll(images.map((image) => image.path).toList());
      }
    } else {
      // Select a single image
      final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImages.clear();
        selectedImages.add(image.path);
      }
    }
  }


  Future<void> openCamera() async {
    final XFile? capturedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (capturedImage != null) {
      captureImagePath.value = capturedImage.path; // Update the observable with the captured image path
      selectedImages.add(captureImagePath.value); // Add captured image to the selectedImages list
    }
  }

  void removeImage(int index) {
    if (index < selectedImages.length) {
      // Remove the image at the specified index
      selectedImages.removeAt(index);
    } else if (index == selectedImages.length && captureImagePath.value.isNotEmpty) {
      // If trying to remove the captured image, clear the captureImagePath
      captureImagePath.value = '';
    }
  }




  Future<void> fetchUserDetails() async {
    final DatabaseReference usersRef = FirebaseDatabase.instance.ref('users'); // Adjust the reference to your users node
    final User? currentUser = FirebaseAuth.instance.currentUser; // Get the current logged-in user

    if (currentUser == null) {
      print("User not logged in.");
      return;
    }

    // Fetch user details using their UID
    final userSnapshot = await usersRef.child(currentUser.uid).get();
    if (userSnapshot.exists) {
      final userData = userSnapshot.value as Map<dynamic, dynamic>;

      // Update observables with user data
      userName.value = userData['name'] ?? 'Unnamed'; // Default to 'Unnamed' if name not found
      userProfilePic.value = userData['imageUrl'] ?? AppImagePaths.placeholder1; // Use placeholder if imageUrl not found
    } else {
      print("User data does not exist.");
    }
  }


  void toggleNext() {
    isNextClicked.value = !isNextClicked.value;
  }
  // Function to update post text
  void updatePostText(String text) {
    postText.value = text;
  }
  void toggleCameraIconColor() {
    cameraIconColor.value = cameraIconColor.value == AppColor.orangeLight
        ? Colors.green
        : AppColor.orangeLight; // Toggle color for camera icon
  }

  void togglePhotoIconColor() {
    photoIconColor.value = photoIconColor.value == AppColor.orangeLight
        ? Colors.green
        : AppColor.orangeLight; // Toggle color for photo icon
  }

  void toggleLocationIconColor() {
    locationIconColor.value = locationIconColor.value == AppColor.orangeLight
        ? Colors.green
        : AppColor.orangeLight; // Toggle color for location icon
  }

  void togglePersonIconColor() {
    personIconColor.value = personIconColor.value == AppColor.orangeLight
        ? Colors.green
        : AppColor.orangeLight; // Toggle color for person icon
  }




}
