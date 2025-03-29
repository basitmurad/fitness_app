import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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

  List<int> _generateBirthYears() {
    final currentYear = DateTime.now().year;
    return List.generate(68, (index) => currentYear - 13 - index);
  }

  void _calculateWeightLoss() {
    if (_weightController.text.isNotEmpty && _targetWeightController.text.isNotEmpty) {
      try {
        final weight = double.parse(_weightController.text);
        final targetWeight = double.parse(_targetWeightController.text);

        // Only calculate if units are the same
        if (_weightUnit == _targetWeightUnit) {
          setState(() {
            _weightLossPercentage = ((weight - targetWeight) / weight * 100);
          });
        } else {
          // If units are different, convert to the same unit before calculating
          double convertedWeight = weight;
          double convertedTargetWeight = targetWeight;

          if (_weightUnit == 'lbs' && _targetWeightUnit == 'kg') {
            convertedWeight = weight * 0.453592; // Convert lbs to kg
          } else if (_weightUnit == 'kg' && _targetWeightUnit == 'lbs') {
            convertedTargetWeight = targetWeight * 0.453592; // Convert lbs to kg
          }

          setState(() {
            _weightLossPercentage = ((convertedWeight - convertedTargetWeight) / convertedWeight * 100);
          });
        }
      } catch (e) {
        // Handle parsing error
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
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
                  // Name Fields
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter your first name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter your last name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

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
                            setState(() {
                              _gender = 'male';
                            });
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
                            child: Row(
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
                            setState(() {
                              _gender = 'female';
                            });
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
                            child: Row(
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
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
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
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _heightUnit = 'cm';
                                });
                              },
                              child: Container(
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
                                setState(() {
                                  _heightUnit = 'ft';
                                });
                              },
                              child: Container(
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
                      if (_heightUnit == 'cm')
                        Expanded(
                          child: TextFormField(
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Height in cm',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your height';
                              }
                              return null;
                            },
                          ),
                        )
                      else
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _heightFtController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Feet',
                                  ),
                                  validator: (value) {
                                    if (_heightUnit == 'ft' && (value == null || value.isEmpty)) {
                                      return 'Required';
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
                                  decoration: const InputDecoration(
                                    hintText: 'Inches',
                                  ),
                                  validator: (value) {
                                    if (_heightUnit == 'ft' && (value == null || value.isEmpty)) {
                                      return 'Required';
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
                    children: [
                      Container(
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
                              child: Container(
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
                              child: Container(
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Weight in $_weightUnit',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current weight';
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
                    children: [
                      Container(
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
                              child: Container(
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
                              child: Container(
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Target weight in $_targetWeightUnit',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your target weight';
                            }
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
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Note',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'You will lose ${_weightLossPercentage!.toStringAsFixed(1)}% of your body weight.',
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process data and save profile
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile saved successfully')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Profile',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _heightController.dispose();
    _heightFtController.dispose();
    _heightInController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    super.dispose();
  }
}