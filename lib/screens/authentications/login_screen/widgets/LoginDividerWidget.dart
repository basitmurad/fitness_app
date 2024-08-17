import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginDividerWidget extends StatelessWidget {
  const LoginDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Or Sign In With',
              style: TextStyle(fontSize: 16 ,color: Colors.black),
            ),
          ),
          Expanded(
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
