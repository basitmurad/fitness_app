import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/AppSizes.dart';
import '../../../utils/constants/AppString.dart';

class BodyGoalScreen extends StatelessWidget {
  const BodyGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.appBarHeight),
                  Text(
                    textAlign: TextAlign.center,
                    AppStrings.textGoal,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 79),
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
