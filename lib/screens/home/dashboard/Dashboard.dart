import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppDevicesUtils.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:fitness/utils/constants/AppString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppStrings.dashboard),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColor.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ClipOval(

                    child: Image.asset(
                      fit: BoxFit.fill,
                        height: 55,
                        width: 55,
                        AppImagePaths.gymPic),
                  ),

                   Text(
                    AppStrings.menu,
                    style: const TextStyle(
                      color: AppColor.buttonDisabled,
                      fontSize: 24,
                    ),
                  ),
                   Text(
                    AppStrings.menu,
                    style: const TextStyle(
                      color: AppColor.buttonDisabled,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title:  Text(AppStrings.home),
              onTap: () {
                // Handle navigation to Home
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title:  Text(AppStrings.setting),
              onTap: () {
                // Handle navigation to Settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title:  Text(AppStrings.logout),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: AppDevicesUtils.getScreenWidth(context) * 0.5,
              width: AppDevicesUtils.getScreenWidth(context) * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

        Container(
          width: double.infinity,
          height: AppDevicesUtils.getScreenWidth(context) * 0.5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child:
          Stack(

            alignment: Alignment.center, // Center both horizontally and vertically
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppImagePaths.gymPic, // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.check, // Replace with your desired icon
                  color: CupertinoDynamicColor.withBrightness(
                    color: Colors.white,
                    darkColor: Colors.redAccent,
                  ),
                ),
                label: Text(
                  "Check",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const CupertinoDynamicColor.withBrightness(
                      color: Colors.white,
                      darkColor: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          )

        )

            ,

            // Row(
            //   children: [
            //     Expanded(
            //       child: Stack(
            //         children: [
            //           // Background image
            //           Positioned.fill(
            //             child: Image.asset(
            //               AppImagePaths.gymPic, // Replace with your image path
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //           // Widgets on top of the image
            //           Positioned(
            //             top: 10,
            //             left: 10,
            //             child: Text(
            //               'Your Text Here',
            //               style: Theme.of(context).textTheme.labelMedium?.copyWith(
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     const VerticalDivider(
            //       color: Colors.black,
            //       width: 2,
            //     ),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             'What is your weight?',
            //             style: Theme.of(context).textTheme.labelMedium?.copyWith(
            //               color: AppColor.black,
            //             ),
            //           ),
            //           const SizedBox(height: 5),
            //           const Text('What is your age?'),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),



          ],
        ),
      ),
    );
  }
}
