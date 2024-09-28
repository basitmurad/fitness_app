import 'package:flutter/cupertino.dart';

import '../../../../utils/constants/AppColor.dart';
import '../../../../utils/constants/AppImagePaths.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      height: 300,
      color: AppColor.postBackColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: AppColor.error,
              // Replace with your image
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {},
                child: Image.asset(AppImagePaths.heart,
                    width: 26, height: 26),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Image.asset(AppImagePaths.icon,
                    width: 24, height: 25),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Image.asset(AppImagePaths.send1,
                    width: 26, height: 26),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Image.asset(AppImagePaths.bookmark,
                    width: 26, height: 26),
              ),
              const SizedBox(width: 8),
              SizedBox(height: 12),
            ],
          ),
        ],
      ),
    );
  }
}
