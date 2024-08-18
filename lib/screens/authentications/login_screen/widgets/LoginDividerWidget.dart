import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginDividerWidget extends StatelessWidget {
  const LoginDividerWidget({
    super.key, required this.dark,
  });
  final bool dark;


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Or Sign In With',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
