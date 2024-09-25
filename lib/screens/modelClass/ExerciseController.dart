import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ExerciseController extends GetxController {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref('Exercise').child('Abs Workout');

  Future<void> fetchExerciseData() async {
    try {
      final DatabaseEvent event = await _databaseReference.child('Jumping Jack').once();
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        printExerciseData(data);
      } else {
        print("No data found.");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }
  void printExerciseData(Map<dynamic, dynamic> data) {
    print("Title: ${data['title']}");
    print("Description: ${data['description']}\n");

    print("Breathing Tips:");
    for (var tip in data["breathingTips"]) {
      print("  - Title: ${tip['title']}");
      print("    Description: ${tip['description']}");
    }

    print("\nCommon Mistakes:");
    for (var mistake in data["commonMistakes"]) {
      print("  - Title: ${mistake['title']}");
      print("    Description: ${mistake['description']}");
    }

    print("\nFocus Areas:");
    for (var area in data["focusAreas"]) {
      print("  - $area");
    }

    print("\nInstruction:");
    print("  ${data['instruction']}\n");

    print("Multimedia:");
    for (var gender in data["multimedia"].keys) {
      if (data["multimedia"].containsKey(gender)) {
        final media = data["multimedia"][gender];
        // Check if gender is a String before calling capitalize
        if (gender is String) {
          print("  ${gender[0].toUpperCase()}${gender.substring(1)}:");  // Capitalizing manually
        }
        print("    Animation Path: ${media['animationPath']}");
        print("    Image Path: ${media['imagePath']}");
        print("    Muscle Path: ${media['musclePath']}");
        print("    Video URL: ${media['videoURL']}\n");
      }
    }
  }



}
