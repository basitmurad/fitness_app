import 'package:flutter/material.dart';
import '../../../../utils/constants/AppColor.dart';

class InputWidget2 extends StatelessWidget {
  const InputWidget2({
    super.key,
    required this.dark,
    required this.focusNode,
    required this.editingController,
    required this.opacity,
    this.ft,
    this.inchController,
  });

  final bool dark;
  final FocusNode focusNode;
  final TextEditingController editingController;
  final double opacity;
  final String? ft;
  final TextEditingController? inchController;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Rounded corners for Container
        child: Container(
          width: ft != null && inchController != null ? 160 : 100,
          // Adjust width for both ft and inch fields
          color: AppColor.lightBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                  controller: editingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: ft ?? 'cm',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: AppColor.lightBlue,
                    border: InputBorder.none, // No border to match rounded container
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              if (inchController != null) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    controller: inchController,
                    decoration: const InputDecoration(
                      hintText: 'inch',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: AppColor.lightBlue,
                      border: InputBorder.none, // No border to match rounded container
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
