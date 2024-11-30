import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DateOfBirthScreenController extends GetxController {
  final currentYear = DateTime.now().year.obs;
  final selectedYear = DateTime.now().year.obs;

  late FixedExtentScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = FixedExtentScrollController(
      initialItem: currentYear.value - 1900,
    );
  }

  void onYearChanged(int index) {
    selectedYear.value = 1900 + index;
  }


}
