import 'package:flutter/cupertino.dart';

class ImageWidgetBody extends StatelessWidget {
  const ImageWidgetBody({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(imageUrl),
          ),
        ),

      ],
    );
  }
}
