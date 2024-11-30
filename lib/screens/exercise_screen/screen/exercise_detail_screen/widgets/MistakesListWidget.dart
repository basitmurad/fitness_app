import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/AppColor.dart';

class MistakesListWidget extends StatelessWidget {
  final List<Map<String, String>> commonMistakes; // List of mistakes with title and description
  final bool dark; // To determine dark mode

  // Constructor to receive parameters
  const MistakesListWidget({
    Key? key,
    required this.commonMistakes,
    required this.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: dark
                ? AppColor.grey.withOpacity(0.1)
                : AppColor.grey.withOpacity(0.2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Align children at the top
              children: [
                Expanded(
                  child: Container(
                    height: 330.0, // Set a height for ListView
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: commonMistakes.length,
                      // Specify the number of items
                      itemBuilder: (context, index) {
                        final mistake = commonMistakes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                margin: const EdgeInsets.only(top: 7, left: 7),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: dark
                                      ? AppColor.white
                                      : AppColor.black.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Add some space between the dot and text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mistake['title']!,
                                      overflow: TextOverflow.ellipsis,
                                      // Handles text overflow
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: dark
                                            ? AppColor.white
                                            : AppColor.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Add some space between lines of text
                                    Text(
                                      mistake['description']!,
                                      maxLines: 3,
                                      // Limit the number of lines
                                      overflow: TextOverflow.ellipsis,
                                      // Handles text overflow
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: dark
                                            ? AppColor.white.withOpacity(0.7)
                                            : AppColor.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ), // Adjust font size as needed
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
