import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/common/widgets/CustomButton.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../../common/widgets/CircularImage.dart';

import 'package:fitness/common/widgets/ButtonWidget.dart';
import 'package:fitness/common/widgets/CustomButton.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../../common/widgets/CircularImage.dart';

class SearchAndSuggestionScreen extends StatelessWidget {
  const SearchAndSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SimpleTextWidget(
            text: 'Add Friends',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: dark ? AppColor.white : AppColor.black,
            fontFamily: 'Poppins',
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: dark ? AppColor.white : AppColor.black,
            ),
          ),
        ),
        body: Column(
          children: [
            // Search field outside of the TabBar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: SearchField(
                suggestions: [
                  'Apple',
                  'Banana',
                  'Cherry',
                  'Date',
                  'Elderberry',
                  'Fig',
                  'Grapes',
                  'Honeydew',
                ].map((fruit) => SearchFieldListItem(fruit)).toList(),
                searchInputDecoration: SearchInputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: const Icon(Icons.search), // Search icon
                  border: const OutlineInputBorder(),
                ),
                onTap: () {
                  print(''); // Handle search item tap
                },
              ),
            ),
            TabBar(
              indicatorColor: AppColor.orangeColor,
              labelColor: dark ? AppColor.white : AppColor.dark, // Sets the text color of the active tab
              unselectedLabelColor: Colors.grey, // Sets the text color of the inactive tabs
              tabs: [
                const Tab(text: 'Friends'),
                const Tab(text: 'Suggested'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Friends Tab
                  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (index, context){

                        return                       UserCard(dark: dark);
                      }),                  // Suggested Tab
                  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (index, context){

                    return                       UserCard1(dark: dark);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// UserCard and UserCard1 classes remain unchanged.

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),

          borderRadius: BorderRadius.circular(4)
      ),
      height: 120,
      width: AppDevicesUtils.screenWidth()* 1.2,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5), // Space between the image and the text

          CircularImage(
            imageUrl: 'https://images.unsplash.com/photo-1727324358652-e82abf20aad2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            size: 98,
          ),
          const SizedBox(width: 10), // Space between the image and the text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5), // Space at the top
              SimpleTextWidget(
                text: 'Rahila Swati',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(height: 1,),
              SimpleTextWidget(
                text: 'You may know “Miachel”',
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: 'Poppins',
              ),
              const SizedBox(height: 4,),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 50,
                    width: 220, // Add a width for proper visibility
                  child: Row(
                    children: [
                    Container(
                    height: 40,
                    width: 91,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.grey1.withOpacity(0.6),
                      ),// Add a width for proper bl

                    child: TextButton(onPressed: (){}, child: SimpleTextWidget(text: 'Remove', fontWeight: FontWeight.w300, fontSize: 16, color: dark ? AppColor.black : AppColor.black, fontFamily: 'Poppins')),),
                    const SizedBox(width: 8,),
                    Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                    height: 40,
                    width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColor.orangeColor
                      ),// Add a width for proper bl

                    child: TextButton(onPressed: (){}, child: const SimpleTextWidget(text: 'Follow', fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white, fontFamily: 'Poppins')),),



                    ],
                  ),
                  ),

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class UserCard1 extends StatelessWidget {
  const UserCard1({
    super.key,
    required this.dark
  });

  final bool dark;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),

          borderRadius: BorderRadius.circular(4)
      ),
      height: 120,
      width: AppDevicesUtils.screenWidth()* 1.2,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5), // Space between the image and the text

          CircularImage(
            imageUrl: 'https://images.unsplash.com/photo-1727324358652-e82abf20aad2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            size: 98,
          ),
          const SizedBox(width: 10),

Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    SimpleTextWidget(
      text: 'Rahila Swati',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: dark ? AppColor.white : AppColor.black,
      fontFamily: 'Poppins',
    ),

    SimpleTextWidget(
      text: '06 post',
      fontWeight: FontWeight.w300,
      fontSize: 12,
      color: dark ? AppColor.white : AppColor.black,
      fontFamily: 'Poppins',
    ),

  ],
),
          const SizedBox(width: 10),

          Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            height: 40,
            width: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColor.orangeColor
            ),// Add a width for proper bl

            child: TextButton(onPressed: (){}, child: const SimpleTextWidget(text: 'Message', fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white, fontFamily: 'Poppins')),),



        ],
      ),
    );
  }
}

