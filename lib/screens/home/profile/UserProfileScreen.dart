import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Card
            Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(

                      child: Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Icon(Icons.task, color: Colors.blue),
                  ],
                ),
              ),
            ),

            // Detailed Card
            Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Title',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'This is a description of the task. It can include details about what needs to be done, deadlines, and other relevant information.',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          child: const Text('Mark as Completed'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),  // Ensure spacing before the next container

                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blueAccent, Colors.pinkAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Task in Progress',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),  // Ensure spacing before progress indicators

                    // Progress Indicator
                    Text(
                      'Task 1: Design New Layout',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: Colors.pink,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    ),
                    const SizedBox(height: 16.0),

                    Text(
                      'Task 2: Implement Authentication',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const LinearProgressIndicator(
                      value: 0.3, // Progress value (0.0 to 1.0)
                      backgroundColor: Colors.white54,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
