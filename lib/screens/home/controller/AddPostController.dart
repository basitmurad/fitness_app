import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/AppColor.dart';

class AddPostController extends GetxController {
  var cameraIconColor = AppColor.orangeLight.obs; // Observable color for the camera icon
  var photoIconColor = AppColor.orangeLight.obs; // Observable color for the photo icon
  var locationIconColor = AppColor.orangeLight.obs; // Observable color for the location icon
  var personIconColor = AppColor.orangeLight.obs; // Observable color for the person icon
  RxBool isNextClicked = false.obs;

  var postText = ''.obs; // Observable for post text
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
