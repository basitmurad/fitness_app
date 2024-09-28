import 'package:fitness/utils/constants/AppColor.dart';
import 'package:fitness/utils/constants/AppImagePaths.dart';
import 'package:flutter/material.dart';

import 'Widgets/PostCard.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Social Screen'), // Optional: Title of the AppBar
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Friends'),
              Tab(text: 'Foryou'),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                // Image with 0% corner radius (square or rectangular)
                const SizedBox(height: 10),
                // Optional: space between the image and the tabs
                // TabBarView for the content of the tabs
                Expanded(
                  child: TabBarView(

                    children: [
                      // Friends Tab Content
                      ListView.builder(
                        itemCount: 10, // Replace with your item count
                        itemBuilder: (context, index) {
                          return PostCard();
                          // Replace with your item conten
                        },
                      ),
                      // Forum Tab Content
                      // Forum Tab Content
                      ListView.builder(
                        itemCount: 10, // Replace with your item count
                        itemBuilder: (context, index) {
                          return PostCard();

                          // Replace with your item conten
                        },
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
