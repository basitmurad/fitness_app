import 'package:flutter/material.dart';

class BuiltYearChoice extends StatefulWidget {
  const BuiltYearChoice({Key? key}) : super(key: key);

  @override
  State<BuiltYearChoice> createState() => _BuiltYearChoiceState();
}

class _BuiltYearChoiceState extends State<BuiltYearChoice> {
  late FixedExtentScrollController _scrollController;
  int _selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(
      initialItem: DateTime.now().year - 1900,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Year'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: ListWheelScrollView.useDelegate(
                controller: _scrollController,
                itemExtent: 50,
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedYear = 1900 + index;
                  });
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    final year = 1900 + index;
                    final isSelected = _selectedYear == year;

                    return Container(
                      width: 150,
                      decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.transparent,

                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          fontSize: 32,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  },
                  childCount: 200, // Adjust range as needed
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Year: $_selectedYear',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
