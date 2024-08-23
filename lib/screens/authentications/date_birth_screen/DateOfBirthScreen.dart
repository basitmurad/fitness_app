import 'package:flutter/material.dart';

class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen({super.key});

  @override
  _DateOfBirthScreenState createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  int? _selectedIndex;

  // Generate a list of years from 1950 to the current year
  List<String> _generateYears() {
    final currentYear = DateTime.now().year;
    return List<String>.generate(
      currentYear - 1950 + 1,
          (index) => (1950 + index).toString(),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final years = _generateYears();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              'Select a Year',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 300, // Adjust height as needed
              child: ListView.builder(
                itemCount: years.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () => _onItemTap(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          years[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
