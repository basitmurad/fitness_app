import 'package:flutter/material.dart';

import '../../../../../utils/constants/AppColor.dart';

class TextWithDot extends StatelessWidget {
  const TextWithDot({
    super.key,
    required this.dark,
    required this.text,
  });

  final bool dark;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns both dot and text to the top
          children: [
            const SizedBox(width: 8),

            Container(

              width: 5,
              height: 5,
              margin: const EdgeInsets.only(top: 4), // Optional to vertically center dot with text
              decoration: BoxDecoration(
                color: dark ? AppColor.white : AppColor.black,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: dark ? AppColor.white : AppColor.black,
                    fontSize: 12,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
