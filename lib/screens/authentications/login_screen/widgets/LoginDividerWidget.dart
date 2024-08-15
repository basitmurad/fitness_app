import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginDividerWidget extends StatelessWidget {
  const LoginDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 2.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'OR',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
