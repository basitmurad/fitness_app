import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../search_screen/UserModel.dart';

class SearchAndSuggestionScreenController extends GetxController{
  var isSearching = false.obs;
  var searchQuery = ''.obs;
  var items = [
    'Apple', 'Banana', 'Mango', 'Orange', 'Grapes', 'Pineapple', 'Strawberry'
  ].obs;

  List<String> get filteredItems => items
      .where((element) => element.toLowerCase().contains(searchQuery.value.toLowerCase()))
      .toList();

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchQuery.value = '';
    }
  }

  var users = <UserModel>[].obs; // Observable list of users
  final DatabaseReference _usersRef = FirebaseDatabase.instance.ref('users');

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      // Fetch data as a one-time read
      DatabaseEvent event = await _usersRef.once();

      // Get the DataSnapshot from the DatabaseEvent
      DataSnapshot snapshot = event.snapshot;

      // Assuming your data is structured under 'users'
      if (snapshot.exists) {
        final Map<dynamic, dynamic> usersData = snapshot.value as Map<dynamic, dynamic>;

        users.value = usersData.entries.map((entry) {
          return UserModel.fromJson(entry.value);
        }).toList();
      } else {
        print('No users found.');
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }
}