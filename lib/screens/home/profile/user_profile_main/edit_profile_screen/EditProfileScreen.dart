import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/CircularImage.dart';
import '../../../../../utils/constants/AppColor.dart';
import '../../../../../utils/helpers/MyAppHelper.dart';
import '../../../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: AppSizes.appBarHeight -15,),
              // Ce
              //nter the image at the top
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back,
                        color: dark ? AppColor.white : AppColor.black),
                  ),
                  Spacer(),  // This pushes the text widget to the center
                  SimpleTextWidget(
                    align: TextAlign.center,
                    text: 'Edit Profile',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: dark ? AppColor.white : AppColor.black,
                    fontFamily: "Poppins",
                  ),
                  Spacer(),  // This ensures the text stays centered
                ],
              ),


              SizedBox(width: AppDevicesUtils.getScreenWidth(context)*0.8,
                child: Divider(
                  height: 2,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: AppSizes.productImageRadius,),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular Image with inner shadow effect
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularImage(
                            imageUrl:
                                'https://images.unsplash.com/photo-1727324358652-e82abf20aad2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            size: 100,
                          ),
                          // Inner shadow simulation using a gradient
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  // Dark center for inner shadow effect
                                  Colors.transparent,
                                  // Fades to transparent
                                ],
                                stops: [0.7, 1.0],
                                // Control the spread of the inner shadow
                                center: Alignment.center,
                                radius: 0.9, // Adjust the radius for the effect
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Camera icon centered over the image
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 4,),
              SimpleTextWidget(text: 'change photo', fontWeight: FontWeight.w400, fontSize: 14, color: dark ? AppColor.white :AppColor.black, fontFamily: "Poppins")
,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // To space items evenly
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to start
                    children: [
                      Text(
                        'Name', // Display the user's name
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: dark ? AppColor.white : AppColor.black,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        '@username', // Display the username
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: dark ? AppColor.white : AppColor.grey,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // Open a dialog to change the user's image
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Change Profile Picture'),
                            content: Text('Do you want to change your profile picture?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Add logic to change profile image
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('Change'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.camera_alt, color: dark ? AppColor.white : AppColor.black),
                  ),
                ],
              )

              // Additional content can go here
              // Example: fields for editing profile or buttons
            ],
          ),
        ),
      ),
    );
  }
}
