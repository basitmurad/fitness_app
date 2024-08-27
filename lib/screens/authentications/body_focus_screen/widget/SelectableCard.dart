import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
class SelectableCard extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final String label; // Add this parameter

  const SelectableCard({
    Key? key,
    required this.selected,
    required this.onTap, required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        width: 100,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: selected ? AppColor.lightBlue : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
