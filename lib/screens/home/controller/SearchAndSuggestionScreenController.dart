import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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
}