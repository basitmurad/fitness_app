import 'package:fitness/screens/home/controller/AddPostController.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../common/widgets/CircularImage.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

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
          onPressed: () {},
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
            onTap: () {},
            child: Container(
              height: 39,
              width: 80,
              decoration: BoxDecoration(
                color: AppColor.orangeLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: SimpleTextWidget(
                  text: 'Next',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar:               Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => IconButton(
            onPressed: () {
              addPostController.toggleCameraIconColor(); // Change color on click
            },
            icon: Icon(
              Icons.camera_alt,
              color: addPostController.cameraIconColor.value, // Reactive color change
            ),
          )),
          Obx(() => IconButton(
            onPressed: () {
              addPostController.togglePhotoIconColor(); // Change color on click
            },
            icon: Icon(
              Icons.photo,
              color: addPostController.photoIconColor.value, // Reactive color change
            ),
          )),
          Obx(() => IconButton(
            onPressed: () {
              addPostController.toggleLocationIconColor(); // Change color on click
            },
            icon: Icon(
              Icons.not_listed_location_rounded,
              color: addPostController.locationIconColor.value, // Reactive color change
            ),
          )),
          Obx(() => IconButton(
            onPressed: () {
              addPostController.togglePersonIconColor(); // Change color on click
            },
            icon: Icon(
              Icons.person,
              color: addPostController.personIconColor.value, // Reactive color change
            ),
          )),
        ],
      )
      ,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Container(
                color: Colors.red,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircularImage(
                      imageUrl:
                      'https://images.unsplash.com/photo-1727324358652-e82abf20aad2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      size: 58,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        SimpleTextWidget(
                            text: 'Kami',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Poppins'),
                        Container(
                          height: 23,
                          width: 100,
                          padding: EdgeInsets.only(left: 4, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            color: AppColor.orangeLight.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(.0),
                                child: Image.asset(
                                    height: 16,
                                    width: 16,
                                    AppImagePaths.send12),
                              )
                            ],
                          ),
                        ),



                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.transparent
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 40,  // Minimum height when TextField is empty
                    maxHeight: 150, // Restrict the maximum height to accommodate 5 lines
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      reverse: true,  // Scroll starts from the bottom
                      child: TextField(

                        minLines: 1,  // TextField starts with a single line
                        maxLines: null,  // Expands indefinitely
                        decoration: InputDecoration(
                          hintText: "What’s on your mind ?",
                          border: InputBorder.none,




                        ),
                        onChanged: (text) {
                          // You can use this to do something when the text changes
                        },
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
