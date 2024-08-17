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
            )
            // Yo ur dashboard content here

            ,
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColor.borderPrimary)),
                    elevation: 8,
                    shadowColor: AppColor.grey.withOpacity(0.2)),
                onPressed: () {},
                child: Text(AppStrings.submit))
          ],
        ),
      ),
    );
  }
}
