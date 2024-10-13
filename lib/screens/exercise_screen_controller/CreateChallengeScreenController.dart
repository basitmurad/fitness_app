
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateChallengeScreenController extends GetxController {
  Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat timeFormat = DateFormat('hh:mm a');
  var selectedChallenges = <String>[].obs;
  var selectedDurations = <int>[].obs; // RxList of selected duration indices
  var selectedDurationIndex = 0.obs; // To hold the selected duration index
  var selectedFitnessIndices = <int>[].obs;
  var selectedWellnessIndices = <int>[].obs;
  var selectedPersonalGrowthIndices = <int>[].obs;
  var selectedSeeListIndices = <int>[].obs;



  RxList<String> lastSelectedFitnessItems = <String>[].obs;
  var lastSelectedWellnessItems = <String>[].obs;
  var lastSelectedPersonalGrowthItems = <String>[].obs;
  var lastSeeListItems = <String>[].obs;
  var lastSelectedDurationsItem = <String>[].obs;





  // Update the selected fitness item
  void updateSelectedFitnessIndex(int index, List<String> fitnessChallenges) {
    if (selectedFitnessIndices.contains(index)) {
      selectedFitnessIndices.remove(index); // Deselect if already selected
      lastSelectedFitnessItems.remove(fitnessChallenges[index]); // Remove from last selected items
    } else {
      selectedFitnessIndices.add(index); // Select the challenge
      lastSelectedFitnessItems.add(fitnessChallenges[index]); // Add to last selected items
    }
  }
// Get tile color for fitness challenge
  Color getFitnessTileColor(int index) {
    return selectedFitnessIndices.contains(index) ? Colors.orange : Colors.white;
  }
// Check if fitness subtitle is visible
  bool isFitnessSubtitleVisible(int index) {
    return selectedFitnessIndices.contains(index);
  }

// Update selected wellness index
  void updateSelectedWellnessIndex(int index, List<String> wellnessChallenges) {
    if (selectedWellnessIndices.contains(index)) {
      selectedWellnessIndices.remove(index); // Deselect if already selected
      lastSelectedWellnessItems.remove(wellnessChallenges[index]); // Remove from last selected items
    } else {
      selectedWellnessIndices.add(index); // Select the challenge
      lastSelectedWellnessItems.add(wellnessChallenges[index]); // Add to last selected items
    }
  }
// Get tile color for wellness challenge
  Color getSelectedWellnessColor(int index) {
    return selectedWellnessIndices.contains(index) ? Colors.orange : Colors.white;
  }
// Check if wellness subtitle is visible
  bool isSelectedWellnessVisible(int index) {
    return selectedWellnessIndices.contains(index);
  }

  void updateSelectedPersonalGrowthIndex(int index, List<String> personalGrowthChallenges) {
    if (selectedPersonalGrowthIndices.contains(index)) {
      selectedPersonalGrowthIndices.remove(index); // Deselect if already selected
      lastSelectedPersonalGrowthItems.remove(personalGrowthChallenges[index]); // Remove from last selected items
    } else {
      selectedPersonalGrowthIndices.add(index); // Select the challenge
      lastSelectedPersonalGrowthItems.add(personalGrowthChallenges[index]); // Add to last selected items
    }
  }
// Get tile color for wellness challenge
  Color getSelectedPersonalGrowthColor(int index) {
    return selectedPersonalGrowthIndices.contains(index) ? Colors.orange : Colors.white;
  }
// Check if wellness subtitle is visible
  bool isSelectedPersonalGrowthVisible(int index) {
    return selectedPersonalGrowthIndices.contains(index);
  }


  // Update this method in your controller
  void updateDurationsIndex(int index, List<String> durations) {
    // If an item is already selected, remove it from the list
    if (selectedDurations.isNotEmpty) {
      // Deselect the previously selected duration
      selectedDurations.clear();
      lastSelectedDurationsItem.clear();
    }

    // Add the new selected duration
    selectedDurations.add(index);
    lastSelectedDurationsItem.add(durations[index]);
    selectedDurationIndex.value = index; // Save the selected duration index globally
  }

// Updated getDurationsColor method remains unchanged
  Color getDurationsColor(int index) {
    return selectedDurations.contains(index) ? Colors.orange : Colors.white;
  }

  String get selectedDuration => lastSelectedDurationsItem.isNotEmpty
      ? lastSelectedDurationsItem[0] // Return the selected duration string
      : 'No duration selected';



// Update method for single selection
  void updateSeeListIndex(int index, List<String> seeList) {
    // Clear previous selections and add the new one
    selectedSeeListIndices.clear();
    selectedSeeListIndices.add(index);
    lastSeeListItems.clear(); // Clear previous items
    lastSeeListItems.add(seeList[index]); // Add the new selected item
  }

  String getSelectedSeeListItem() {
    return lastSeeListItems.isNotEmpty
        ? lastSeeListItems.join(', ') // Return the selected item as a string
        : 'No List selected';
  }

  Color getSeeListColor(int index) {
    return selectedSeeListIndices.contains(index) ? Colors.orange : Colors.white;
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
