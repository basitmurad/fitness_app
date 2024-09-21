
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateChallengeScreenController extends GetxController {
  Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  // Date format for time (hh:mm a)
  final DateFormat timeFormat = DateFormat('hh:mm a');
  // Separate RxInt for each category to track selected index
  var selectedFitnessIndex = (-1).obs;  // No item is selected initially
  var selectedWellnessIndex = (-1).obs; // No item is selected initially
  var selectedPersonalGrowthIndex = (-1).obs; // No item is selected initially
  var selectedDurations = (-1).obs; // No item is selected initially
  var selectedSeeList = (-1).obs; // No item is selected initially
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  // Last selected item for each category (if needed)
  var lastSelectedFitnessItem = ''.obs;
  var lastSelectedWellnessItem = ''.obs;
  var lastSelectedPersonalGrowthItem = ''.obs;
  var lastSelectedDurationsItem = ''.obs;
  var lastSeeListItem = ''.obs;



  // Function to update the selected Fitness item
  void updateSelectedFitnessIndex(int index, List<String> fitnessChallenges) {
    selectedFitnessIndex.value = index; // Update selected index
    lastSelectedFitnessItem.value = fitnessChallenges[index];
    print('lastSelectedFitnessItem${lastSelectedFitnessItem.value}'); // Print selected item
// Store the selected item
  }
  void updateSelectedDurationIndex(int index, List<String> selectedDuration) {
    selectedDurations.value = index; // Update selected index
    lastSelectedDurationsItem.value = selectedDuration[index];
    print('lastSelectedFitnessItem${lastSelectedDurationsItem.value}'); // Print selected item
// Store the selected item
  }

  // Function to update the selected Wellness item
  void updateSelectedWellnessIndex(int index, List<String> wellnessChallenges) {
    selectedWellnessIndex.value = index; // Update selected index
    lastSelectedWellnessItem.value = wellnessChallenges[index];
    print('lastSelectedWellnessItem: ${lastSelectedWellnessItem.value}'); // Print selected item
// Store the selected item
  }

  // Function to update the selected Personal Growth item
  void updateSelectedPersonalGrowthIndex(int index, List<String> personalGrowth) {
    selectedPersonalGrowthIndex.value = index; // Update selected index
    lastSelectedPersonalGrowthItem.value = personalGrowth[index];
    print('lastSelectedPersonalGrowthItem: ${lastSelectedPersonalGrowthItem.value}'); // Print selected item
// Store the selected item
  }
  void updateSeeListIndex(int index, List<String> personalGrowth) {
    selectedSeeList.value = index; // Update selected index
    lastSeeListItem.value = personalGrowth[index];
    print('lastSelectedPersonalGrowthItem: ${lastSeeListItem.value}'); // Print selected item
// Store the selected item
  }

  // Function to get the tile color based on selected index
  Color getFitnessTileColor(int index) {
    return selectedFitnessIndex.value == index ? Colors.orange : Colors.white;
  }
  Color getSeeTileColor(int index) {
    return selectedSeeList.value == index ? Colors.orange : Colors.white;
  }

  Color getWellnessTileColor(int index) {
    return selectedWellnessIndex.value == index ? Colors.orange : Colors.white;
  }

  Color getPersonalGrowthTileColor(int index) {
    return selectedPersonalGrowthIndex.value == index ? Colors.orange : Colors.white;
  }

  Color getSelectDurationTileColor(int index) {
    return selectedDurations.value == index ? Colors.orange : Colors.white;
  }

  // To determine whether the subtitle should be visible
  bool isFitnessSubtitleVisible(int index) {
    return selectedFitnessIndex.value == index;
  }

  bool isWellnessSubtitleVisible(int index) {
    return selectedWellnessIndex.value == index;
  }

  bool isPersonalGrowthSubtitleVisible(int index) {
    return selectedPersonalGrowthIndex.value == index;
  }


  Future<void> pickDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: selectedDateRange.value ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          ),
    );

    if (picked != null) {
      selectedDateRange.value = picked;
    }
  }
  String getFormattedDateRange() {
    if (selectedDateRange.value != null) {
      String startDate = dateFormat.format(selectedDateRange.value!.start);
      String endDate = dateFormat.format(selectedDateRange.value!.end);
      return '$startDate - $endDate';
    } else {
      return 'Select Date';
    }
  }

  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orange, // Header background color (e.g., AM/PM and selected time circle)
              onPrimary: Colors.white, // Header text color
              surface: Colors.white, // Background color of the picker
              onSurface: Colors.black, // Default text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange, // Button text color (e.g., "OK" and "Cancel")
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  // Method to open time picker
  // Future<void> pickTime(BuildContext context) async {
  //   TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: selectedTime.value ?? TimeOfDay.now(),
  //   );
  //
  //   if (picked != null) {
  //     selectedTime.value = picked;
  //   }
  // }

  // Get formatted time
  String getFormattedTime() {
    if (selectedTime.value != null) {
      final now = DateTime.now();
      final dateTime = DateTime(now.year, now.month, now.day, selectedTime.value!.hour, selectedTime.value!.minute);
      return timeFormat.format(dateTime);
    } else {
      return 'Select Time';
    }
  }
}
