import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(


          children: [

            Form(child: Column(children: [


              TextFormField(
                decoration: const InputDecoration(
                label: Text('name'),
                  border: OutlineInputBorder(),
                  hintText: 'Basit Murad',
                ),
              ),

            ],))
          ],

        ),
      ),
    );
  }
}
