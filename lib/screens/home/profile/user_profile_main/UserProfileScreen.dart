import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:fitness/screens/exercise_screen/exercise_detail_screen/widgets/SimpleTextWidget.dart';
import 'package:fitness/screens/home/profile/user_profile_main/widgets/ButtonsWidget.dart';
import 'package:fitness/screens/home/profile/user_profile_main/widgets/UserFollowingPostWidget.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppSizes.dart';
import 'package:fitness/utils/helpers/MyAppHelper.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/CircularImage.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = MyAppHelperFunctions.isDarkMode(context);
    List<String> items = List.generate(10, (index) => 'Item $index');

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back, color: dark ? AppColor.white : AppColor.black)),
            actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
            title: SimpleTextWidget(
                text: 'basit',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: dark ? AppColor.white : AppColor.black,
                fontFamily: "Poppins")),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                CircularImage(
                  imageUrl:
                  'https://images.unsplash.com/photo-1727324358652-e82abf20aad2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  size: 100,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),
                UserFollowingPostWidget(dark: dark),
                const SizedBox(height: AppSizes.spaceBtwSections - 10),
                ButtonsWidget(dark: dark, context: context,),
                const SizedBox(height: 20),

                TabBar(tabs: [
                  const Tab(icon: Icon(Icons.photo ),),
                  const Tab(icon: Icon(Icons.slow_motion_video_rounded ),),
                  const Tab(icon: Icon(Icons.save ),)
                ]
                ,
                  indicatorColor: Colors.orange, // Set the indicator color to orange
                  labelColor: Colors.orange, // Set the color of the selected tab text/icon
                  unselectedLabelColor: dark ? AppColor.white : AppColor.black, // Set color for unselected tabs
                  indicatorSize: TabBarIndicatorSize.label,                 )
,
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 1),
                  height: MediaQuery.of(context).size.height - 250, // Adjust as needed
                  child: TabBarView(
                    children: [



                      DynamicHeightGridView(
                      itemCount: 120,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      builder: (ctx, index) {

                        return Container(

                          margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                          height: 100,
                        width: 50,
                        color: Colors.red,);
                        /// return your widget here.
                      }
                  ),

                      DynamicHeightGridView(
                          itemCount: 120,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          builder: (ctx, index) {

                            return Container(

                              margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                              height: 100,
                              width: 50,
                              color: Colors.yellow,);
                            /// return your widget here.
                          }
                      ),
                      DynamicHeightGridView(
                          itemCount: 120,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          builder: (ctx, index) {

                            return Container(

                              margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                              height: 100,
                              width: 50,
                              color: Colors.red,);
                            /// return your widget here.
                          }
                      ),

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


