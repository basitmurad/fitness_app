import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness/navigation_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart'; // Import FirebaseDatabase

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.name}) : super(key: key);
  // The 'name' parameter seems unused in the form logic provided.
  // If it's needed (e.g., display name), you might want to add a field for it.
  final String name;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _heightFtController = TextEditingController();
  final TextEditingController _heightInController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _targetWeightController = TextEditingController();

  String? _gender;
  int? _birthYear;
  String _heightUnit = 'cm';
  String _weightUnit = 'kg';
  String _targetWeightUnit = 'kg';
  double? _weightLossPercentage;
  bool _isLoading = false; // To show a loading indicator

  List<int> _generateBirthYears() {
    final currentYear = DateTime.now().year;
    // Generate years from (currentYear - 13) down to (currentYear - 13 - 67) = (currentYear - 80)
    // Suitable for ages 13 to 80. Adjust range if needed.
    return List.generate(68, (index) => currentYear - 13 - index);
  }

  void _calculateWeightLoss() {
    if (_weightController.text.isNotEmpty &&
        _targetWeightController.text.isNotEmpty) {
      try {
        final weight = double.parse(_weightController.text);
        final targetWeight = double.parse(_targetWeightController.text);

        // Convert both to a common unit (kg) for calculation
        double weightInKg = (_weightUnit == 'kg') ? weight : weight * 0.453592;
        double targetWeightInKg = (_targetWeightUnit == 'kg')
            ? targetWeight
            : targetWeight * 0.453592;

        // Ensure weight is positive to avoid division by zero or weird percentages
        if (weightInKg > 0) {
          setState(() {
            _weightLossPercentage =
            ((weightInKg - targetWeightInKg) / weightInKg * 100);
          });
        } else {
          setState(() {
            _weightLossPercentage = null;
          });
        }

      } catch (e) {
        // Handle parsing error if text is not a valid number
        debugPrint("Error parsing weight for calculation: $e");
        setState(() {
          _weightLossPercentage = null;
        });
      }
    } else {
      setState(() {
        _weightLossPercentage = null;
      });
    }
  }

  // Removed the incomplete _uploadGenderToFirebase function from here

  @override
  void dispose() {
    _heightController.dispose();
    _heightFtController.dispose();
    _heightInController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    super.dispose();
  }



  Future<void> saveProfile() async {
    // 1. Validate Gender Selection
    if (_gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your gender.'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Stop execution if gender is not selected
    }

    // 2. Validate Form Fields
    if (!_formKey.currentState!.validate()) {
      return; // Stop if form validation fails
    }

    // 3. Show Loading Indicator
    setState(() {
      _isLoading = true;
    });

    // 4. Prepare Data for Firebase
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // Handle case where user is not logged in (shouldn't happen if auth flow is correct)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: User not logged in.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() { _isLoading = false; });
      return;
    }
    final userId = currentUser.uid;
    final databaseReference = FirebaseDatabase.instance.ref('users/$userId');

    // Prepare height data structure
    Map<String, dynamic> heightData = {};
    double? heightInCm; // Store a consistent value if needed later
    try {
      if (_heightUnit == 'cm') {
        final cmValue = double.parse(_heightController.text);
        heightData = {'value': cmValue, 'unit': 'cm'};
        heightInCm = cmValue;
      } else {
        final ftValue = int.parse(_heightFtController.text);
        final inValue = int.parse(_heightInController.text);
        heightData = {'feet': ftValue, 'inches': inValue, 'unit': 'ft'};
        // Optionally convert ft/in to cm for consistent storage/use elsewhere
        heightInCm = (ftValue * 30.48) + (inValue * 2.54);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid height format: $e'), backgroundColor: Colors.red),
      );
      setState(() { _isLoading = false; });
      return;
    }

    // Prepare weight data structure
    Map<String, dynamic> weightData = {};
    try {
      weightData = {
        'value': double.parse(_weightController.text),
        'unit': _weightUnit
      };
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid current weight format: $e'), backgroundColor: Colors.red),
      );
      setState(() { _isLoading = false; });
      return;
    }

    // Prepare target weight data structure
    Map<String, dynamic> targetWeightData = {};
    try {
      targetWeightData = {
        'value': double.parse(_targetWeightController.text),
        'unit': _targetWeightUnit
      };
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid target weight format: $e'), backgroundColor: Colors.red),
      );
      setState(() { _isLoading = false; });
      return;
    }

    // 5. Get and save FCM token
    String? fcmToken;
    try {
      // Request notification permissions first
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // Get the token
        fcmToken = await messaging.getToken();
        if (kDebugMode) {
          print('FCM Token: $fcmToken');
        }
      } else {
        if (kDebugMode) {
          print('User declined or has not accepted notification permissions');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting FCM token: $e');
      }
      // Continue with profile save even if FCM fails
    }

    final Map<String, dynamic> profileData = {
      'gender': _gender,
      'birthYear': _birthYear,
      'height': heightData,
      'currentWeight': weightData,
      'targetWeight': targetWeightData,
      // Optionally store the calculated percentage
      if (_weightLossPercentage != null) 'weightLossPercentage': _weightLossPercentage,
      // Optionally store the height consistently in cm
      if (heightInCm != null) 'heightInCm': heightInCm,
      // Store the timestamp of the update
      'profileLastUpdated': ServerValue.timestamp,
      // Add FCM token if available
      if (fcmToken != null) 'fcmToken': fcmToken,
      // If you intended to save the name passed to the widget:
      // 'name': widget.name,
    };

    // 6. Save to Firebase
    try {
      await databaseReference.update(profileData);

      // Setup FCM topic subscriptions based on user preferences
      if (fcmToken != null) {
        // Subscribe to topics based on user's profile
        await FirebaseMessaging.instance.subscribeToTopic('fitness_${_gender?.toLowerCase() ?? 'all'}');

        // You could also subscribe to topics based on other profile data
        // For example, age group or fitness goals
        if (_birthYear != null) {
          int age = DateTime.now().year - _birthYear!;
          String ageGroup = age < 30 ? 'young_adult' : (age < 50 ? 'adult' : 'senior');
          await FirebaseMessaging.instance.subscribeToTopic('fitness_$ageGroup');
        }
      }

      // 7. Show Success Message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Get.off(() => NavigationMenu());

    } catch (e) {
      // 8. Show Error Message
      debugPrint('Error saving profile: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save profile: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // 9. Hide Loading Indicator
      if (mounted) { // Check if the widget is still in the tree
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

// Helper function to manage FCM token updates
  Future<void> updateFCMToken() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      // Request permission first
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {

        // Get the token
        String? token = await messaging.getToken();
        if (token != null) {
          // Save to user's profile
          await FirebaseDatabase.instance
              .ref('users/${currentUser.uid}/fcmToken')
              .set(token);

          if (kDebugMode) {
            print('FCM Token updated successfully');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating FCM token: $e');
      }
    }
  }

// Function to configure FCM when the app starts
  Future<void> configureFCM() async {
    // Request permission
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();

    // Configure FCM handlers
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      if (message.notification != null) {
        if (kDebugMode) {
          print('Message also contained a notification: ${message.notification}');
        }

        // You could show a custom notification here
        // Or use the system notification which is automatically displayed
      }
    });

    // Handle notification when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('A notification was tapped by the user!');
        print('Message data: ${message.data}');
      }

      // You could navigate to a specific screen based on the message
      if (message.data['type'] == 'workout') {
        // Example: Navigate to workout screen
        // Get.to(() => WorkoutScreen(id: message.data['workoutId']));
      }
    });

    // Update token on app start
    await updateFCMToken();

    // Setup token refresh listener
    FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
      if (kDebugMode) {
        print('FCM token refreshed');
      }
      updateFCMToken();
    });
  }
  // Future<void> _saveProfile() async {
  //   // 1. Validate Gender Selection
  //   if (_gender == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please select your gender.'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return; // Stop execution if gender is not selected
  //   }
  //
  //   // 2. Validate Form Fields
  //   if (!_formKey.currentState!.validate()) {
  //     return; // Stop if form validation fails
  //   }
  //
  //   // 3. Show Loading Indicator
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   // 4. Prepare Data for Firebase
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser == null) {
  //     // Handle case where user is not logged in (shouldn't happen if auth flow is correct)
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Error: User not logged in.'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     setState(() { _isLoading = false; });
  //     return;
  //   }
  //   final userId = currentUser.uid;
  //   final databaseReference = FirebaseDatabase.instance.ref('users/$userId');
  //
  //   // Prepare height data structure
  //   Map<String, dynamic> heightData = {};
  //   double? heightInCm; // Store a consistent value if needed later
  //   try {
  //     if (_heightUnit == 'cm') {
  //       final cmValue = double.parse(_heightController.text);
  //       heightData = {'value': cmValue, 'unit': 'cm'};
  //       heightInCm = cmValue;
  //     } else {
  //       final ftValue = int.parse(_heightFtController.text);
  //       final inValue = int.parse(_heightInController.text);
  //       heightData = {'feet': ftValue, 'inches': inValue, 'unit': 'ft'};
  //       // Optionally convert ft/in to cm for consistent storage/use elsewhere
  //       heightInCm = (ftValue * 30.48) + (inValue * 2.54);
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Invalid height format: $e'), backgroundColor: Colors.red),
  //     );
  //     setState(() { _isLoading = false; });
  //     return;
  //   }
  //
  //
  //   // Prepare weight data structure
  //   Map<String, dynamic> weightData = {};
  //   try {
  //     weightData = {
  //       'value': double.parse(_weightController.text),
  //       'unit': _weightUnit
  //     };
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Invalid current weight format: $e'), backgroundColor: Colors.red),
  //     );
  //     setState(() { _isLoading = false; });
  //     return;
  //   }
  //
  //   // Prepare target weight data structure
  //   Map<String, dynamic> targetWeightData = {};
  //   try {
  //     targetWeightData = {
  //       'value': double.parse(_targetWeightController.text),
  //       'unit': _targetWeightUnit
  //     };
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Invalid target weight format: $e'), backgroundColor: Colors.red),
  //     );
  //     setState(() { _isLoading = false; });
  //     return;
  //   }
  //
  //
  //   final Map<String, dynamic> profileData = {
  //     'gender': _gender,
  //     'birthYear': _birthYear,
  //     'height': heightData,
  //     'currentWeight': weightData,
  //     'targetWeight': targetWeightData,
  //     // Optionally store the calculated percentage
  //     if (_weightLossPercentage != null) 'weightLossPercentage': _weightLossPercentage,
  //     // Optionally store the height consistently in cm
  //     if (heightInCm != null) 'heightInCm': heightInCm,
  //     // Store the timestamp of the update
  //     'profileLastUpdated': ServerValue.timestamp,
  //     // If you intended to save the name passed to the widget:
  //     // 'name': widget.name,
  //   };
  //
  //   // 5. Save to Firebase
  //   try {
  //     await databaseReference.update(profileData);
  //
  //     // 6. Show Success Message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Profile saved successfully!'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //
  //     Get.off(()=> NavigationMenu());
  //     // Optionally navigate away or update UI further
  //     // Navigator.pop(context); // Example: Go back after saving
  //
  //   } catch (e) {
  //     // 7. Show Error Message
  //     debugPrint('Error saving profile: ${e.toString()}');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to save profile: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } finally {
  //     // 8. Hide Loading Indicator
  //     if (mounted) { // Check if the widget is still in the tree
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    // (Keep the existing build method structure as provided in the question)
    // ... AppBar, SafeArea, SingleChildScrollView, Padding, Form ...

    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // (Existing Name Fields - if you add them)
                  // const SizedBox(height: 24),

                  // Gender Selection
                  const Text(
                    'Gender',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() { _gender = 'male'; });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: _gender == 'male' ? Colors.deepOrange : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _gender == 'male' ? Colors.deepOrange : Colors.grey.shade300,
                              ),
                            ),
                            child: Row( /* ... Male Icon/Text ... */
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.male,
                                  color: _gender == 'male' ? Colors.white : Colors.black,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Male',
                                  style: TextStyle(
                                    color: _gender == 'male' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() { _gender = 'female'; });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: _gender == 'female' ? Colors.deepOrange : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _gender == 'female' ? Colors.deepOrange : Colors.grey.shade300,
                              ),
                            ),
                            child: Row( /* ... Female Icon/Text ... */
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.female,
                                  color: _gender == 'female' ? Colors.white : Colors.black,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Female',
                                  style: TextStyle(
                                    color: _gender == 'female' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Add a small message if gender isn't selected (optional visual cue)
                  if (_gender == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Please select a gender',
                        style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 24),


                  // Birth Year Dropdown
                  const Text(
                    'Birth Year',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonFormField<int>(
                      // ... (rest of DropdownButtonFormField properties as before)
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
                        errorStyle: TextStyle(height: 0.01, color: Colors.transparent), // Hide default error text space if needed
                      ),
                      hint: const Text('Select your birth year'),
                      value: _birthYear,
                      isExpanded: true,
                      items: _generateBirthYears().map((year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _birthYear = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your birth year';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),


                  // Height Input
                  const Text(
                    'Height',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align items better with validation text
                    children: [
                      // Unit Toggle Buttons (cm/ft)
                      Container(
                        // ... (Unit toggle button decoration)
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() { _heightUnit = 'cm'; });
                                // Clear ft/in fields if switching to cm
                                _heightFtController.clear();
                                _heightInController.clear();
                              },
                              child: Container( /* ... Cm Button ... */
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _heightUnit == 'cm' ? Colors.deepOrange : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  'Cm',
                                  style: TextStyle(
                                    color: _heightUnit == 'cm' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() { _heightUnit = 'ft'; });
                                // Clear cm field if switching to ft/in
                                _heightController.clear();
                              },
                              child: Container( /* ... Ft Button ... */
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _heightUnit == 'ft' ? Colors.deepOrange : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  'Ft',
                                  style: TextStyle(
                                    color: _heightUnit == 'ft' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Conditional Height Input Fields
                      if (_heightUnit == 'cm')
                        Expanded(
                          child: TextFormField(
                            controller: _heightController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              hintText: 'Height in cm',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            validator: (value) {
                              if (_heightUnit == 'cm') { // Only validate if 'cm' is selected
                                if (value == null || value.isEmpty) {
                                  return 'Enter height';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Invalid number';
                                }
                                // Add reasonable range validation if desired
                                final height = double.parse(value);
                                if (height <= 0 || height > 300) {
                                  return 'Invalid height';
                                }
                              }
                              return null;
                            },
                          ),
                        )
                      else
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align validation messages
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _heightFtController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Feet',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  validator: (value) {
                                    if (_heightUnit == 'ft') { // Only validate if 'ft' is selected
                                      if (value == null || value.isEmpty) {
                                        return 'Req.'; // Short message
                                      }
                                      if (int.tryParse(value) == null) {
                                        return 'Inv.';
                                      }
                                      // Add reasonable range validation if desired
                                      final feet = int.parse(value);
                                      if (feet < 0 || feet > 10) {
                                        return 'Inv.';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  controller: _heightInController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Inches',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  validator: (value) {
                                    if (_heightUnit == 'ft') { // Only validate if 'ft' is selected
                                      if (value == null || value.isEmpty) {
                                        return 'Req.';
                                      }
                                      if (int.tryParse(value) == null) {
                                        return 'Inv.';
                                      }
                                      // Add reasonable range validation if desired
                                      final inches = int.parse(value);
                                      if (inches < 0 || inches >= 12) { // Inches should be 0-11
                                        return 'Inv.';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Weight Input
                  const Text(
                    'Current Weight',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Unit Toggle Buttons (kg/lbs)
                      Container(
                        // ... (Unit toggle button decoration)
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _weightUnit = 'kg';
                                  _calculateWeightLoss();
                                });
                              },
                              child: Container(/* ... Kg Button ... */
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _weightUnit == 'kg' ? Colors.deepOrange : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  'Kg',
                                  style: TextStyle(
                                    color: _weightUnit == 'kg' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _weightUnit = 'lbs';
                                  _calculateWeightLoss();
                                });
                              },
                              child: Container( /* ... Lbs Button ... */
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _weightUnit == 'lbs' ? Colors.deepOrange : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  'Lbs',
                                  style: TextStyle(
                                    color: _weightUnit == 'lbs' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Weight in $_weightUnit',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter weight';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Invalid number';
                            }
                            // Add reasonable range validation if desired
                            final weight = double.parse(value);
                            if (weight <= 0 || weight > 700) { // Adjust range as needed
                              return 'Invalid weight';
                            }
                            return null;
                          },
                          onChanged: (_) => _calculateWeightLoss(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),


                  // Target Weight Input
                  const Text(
                    'Target Weight',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Unit Toggle Buttons (kg/lbs)
                      Container(
                        // ... (Unit toggle button decoration)
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _targetWeightUnit = 'kg';
                                  _calculateWeightLoss();
                                });
                              },
                              child: Container(/* ... Kg Button ... */
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _targetWeightUnit == 'kg' ? Colors.deepOrange : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  'Kg',
                                  style: TextStyle(
                                    color: _targetWeightUnit == 'kg' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _targetWeightUnit = 'lbs';
                                  _calculateWeightLoss();
                                });
                              },
                              child: Container( /* ... Lbs Button ... */
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _targetWeightUnit == 'lbs' ? Colors.deepOrange : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  'Lbs',
                                  style: TextStyle(
                                    color: _targetWeightUnit == 'lbs' ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _targetWeightController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Target weight in $_targetWeightUnit',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter target';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Invalid number';
                            }
                            // Add reasonable range validation if desired
                            final target = double.parse(value);
                            if (target <= 0 || target > 700) { // Adjust range as needed
                              return 'Invalid target';
                            }
                            // Optionally, validate target vs current weight
                            // final current = double.tryParse(_weightController.text);
                            // if (current != null && target > current && _weightLossPercentage != null && _weightLossPercentage > 0) {
                            //    return 'Target > current';
                            // }
                            return null;
                          },
                          onChanged: (_) => _calculateWeightLoss(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),


                  // Weight Loss Note
                  if (_weightLossPercentage != null && _weightLossPercentage! > 0)
                    Container( /* ... (Weight loss note display) ... */
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade50, // Lighter orange/yellow
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.shade200)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Projected Weight Loss',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'This goal represents approximately a ${_weightLossPercentage!.toStringAsFixed(1)}% reduction in body weight.',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  else if (_weightLossPercentage != null && _weightLossPercentage! < 0)
                    Container( /* ... (Weight gain note display) ... */
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.shade200)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Projected Weight Gain',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'This goal represents approximately a ${(_weightLossPercentage! * -1).toStringAsFixed(1)}% increase in body weight.',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : saveProfile, // Disable button when loading
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBackgroundColor: Colors.grey, // Indicate disabled state
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : const Text(
                        'Save Profile',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add some bottom padding
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Removed the standalone uploadGenderToFirebase function outside the class