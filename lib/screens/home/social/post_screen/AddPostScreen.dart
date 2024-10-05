
import 'package:fitness/utils/helpers/MyAppHelper.dart';

import 'package:flutter/material.dart';

import '../../../../common/widgets/CircularImage.dart';
import '../../../../utils/constants/AppColor.dart';
import '../../../exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  CircularImage(
                    imageUrl:
                    'https://images.unsplash.com/photo-1727324358652-e82abf20aad2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    size: 68,
                  ),
                  SizedBox(width: 5,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleTextWidget(text: 'Kami', fontWeight: FontWeight.w400, fontSize: 12, color: Colors.black, fontFamily: 'Poppins')

,
                      Container(
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColor.orangeLight,
                          borderRadius: BorderRadius.circular(4),

                        ),
                        child: Row(
                          children: [
                            

                          ],
                        ),

                      )

                    ],
                  )
                ],
              ),
              // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }
}
