import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,


              decoration: const BoxDecoration(
                color: Colors.cyan,
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple], // Start and end colors
                  begin: Alignment.topLeft, // Start point
                  end: Alignment.bottomRight, // End point
                ),
              ),
              child: const Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
