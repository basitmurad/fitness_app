import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String emailKey = 'email';
  static const String passwordKey = 'password';
  static const String genderKey = 'gender';
  static const String nameKey = 'name';
  static const String numberKey = 'number';
  static const String ageKey = 'age';
  static const String heightKey = 'height';
  static const String weightKey = 'weight';
  static const String targetWeightKey = 'target_weight';
  static const String mainGoalKey = 'main_goal';
  static const String selectedCardsKey = 'selected_cards';

  // Save user data to SharedPreferences
  static Future<void> saveUserData({
    required String email,
    required String password,
    required String gender,
    required String name,
    required String age,
    required String height,
    required String weight,
    required String targetWeight,
    required String mainGoal,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
    await prefs.setString(passwordKey, password);
    await prefs.setString(genderKey, gender);
    await prefs.setString(nameKey, name);
    await prefs.setString(ageKey, age);
    await prefs.setString(heightKey, height);
    await prefs.setString(weightKey, weight);
    await prefs.setString(targetWeightKey, targetWeight);
    await prefs.setString(mainGoalKey, mainGoal);
  }

  // Get user data from SharedPreferences
  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      emailKey: prefs.getString(emailKey),
      passwordKey: prefs.getString(passwordKey),
      genderKey: prefs.getString(genderKey),
      nameKey: prefs.getString(nameKey),
      ageKey: prefs.getString(ageKey),
      heightKey: prefs.getString(heightKey),
      weightKey: prefs.getString(weightKey),
      targetWeightKey: prefs.getString(targetWeightKey),
      mainGoalKey: prefs.getString(mainGoalKey),
    };
  }
}
