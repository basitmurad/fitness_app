import 'package:flutter/cupertino.dart';
import '../../utils/constants/AppSizes.dart';

class MyAppGridLayout extends StatelessWidget {
  const MyAppGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 143,
    this.height = 140, // Add height parameter
  });

  final int itemCount;
  final double? mainAxisExtent;
  final double height; // Define the height of the grid
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: height, // Set the height of the widget
      child: GridView.builder(

        scrollDirection: Axis.horizontal, // Set scroll direction to horizontal
        itemCount: itemCount,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(), // Allows for smooth scrolling
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Display one item per row, creating a horizontal list
          mainAxisSpacing: AppSizes.gridViewSpacing -12,
          crossAxisSpacing: AppSizes.gridViewSpacing -8,
          mainAxisExtent: mainAxisExtent, // Controls the width of each item
        ),
        itemBuilder: itemBuilder,
      ),
    );
  }
}
