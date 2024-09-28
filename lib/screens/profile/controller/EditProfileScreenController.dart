import 'package:fitness/common/snackbar/ShowSnackbar.dart';
import 'package:fitness/utils/constants/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreenController extends GetxController {
  var name = ''.obs; // Reactive variable to store the user's name
  final TextEditingController editingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Fetch initial name value if needed (e.g., from database)
    // This is just an example; update this as per your logic
    name.value = 'Current Username';
  }

  void showChangeNameDialog(BuildContext context) {
    editingController.text = name.value; // Pre-fill the current name in the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Name', style: TextStyle(fontFamily: "Poppins")),
          content: TextField(
            controller: editingController,
            decoration: const InputDecoration(
              labelText: 'Enter new name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (editingController.text.isEmpty) {
                  ShowSnackbar.showMessage(
                    title: 'Empty',
                    message: 'Please enter a name',
                    backgroundColor: AppColor.error,
                  );
                } else {
                  name.value = editingController.text; // Update the name
                  // You can add a call to update the name in a database here
                  Navigator.of(context).pop();
                  ShowSnackbar.showMessage(
                    title: 'Success',
                    message: 'Name updated',
                    backgroundColor: AppColor.success,
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
